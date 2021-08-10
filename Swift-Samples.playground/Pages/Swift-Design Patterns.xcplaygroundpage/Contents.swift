// Factory design pattern

//Start: Factory design pattern
protocol Serializable {
    func serializer  ()
}

class JSONSerializer: Serializable {
    func serializer() {
        print("JSONSerializer \(#function)")
    }
}

class PropertyListSerializer: Serializable {
    func serializer () {
        print("PropertyListSerializer \(#function)")
    }
    
}

class XMLSerializer: Serializable {
    func serializer (){
        print("XMLSerializer \(#function)")
    }
    
}

enum Serializers {
    case json
    case plist
    case xml
}


struct SerializerFactory
{
    
  public static func makeSerializers(_ type: Serializers)-> Serializable? {
        
        let result: Serializable?
        switch type {
        case .json: result = JSONSerializer()
        case .plist: result =  PropertyListSerializer()
        case .xml: result = XMLSerializer()
        }
       return result
    }

    
}



let ser1 =  SerializerFactory.makeSerializers(.json)
ser1?.serializer()

let ser2 =  SerializerFactory.makeSerializers(.plist)
ser1?.serializer()

let ser3 =  SerializerFactory.makeSerializers(.xml)
ser1?.serializer()

//END: Factory design pattern


// START: Adapter design pattern

protocol PaymentGateway {
    func receivePayment(amount: Double)
    var totalPayments: Double {get}
}

class PayPal: PaymentGateway {
    private var total = 0.0
    
    func receivePayment(amount: Double) {
        total += amount
    }
    
    var totalPayments: Double {
        print("Total payments received via PayPal: \(total)")
        return total
    }
}

class Stripe: PaymentGateway {
    private var total = 0.0
    
    func receivePayment(amount: Double) {
        total += amount
    }
    
    var totalPayments: Double {
        print("Total payments received via Stripe: \(total)")
        return total
    }
}


let paypal = PayPal()
paypal.receivePayment(amount: 100)
paypal.receivePayment(amount: 200)
paypal.receivePayment(amount: 499)

let stripe = Stripe()
stripe.receivePayment(amount: 5.99)
stripe.receivePayment(amount: 25)
stripe.receivePayment(amount: 9.99)

var paymentGateways: [PaymentGateway] = [paypal, stripe]


// third-party class, that doesn't conform to PaymentGateway
class AmazonPayments {
    var payments = 0.0
    
    func paid(value: Double, currency: String) {
        payments += value
        print("Paid \(currency)\(value) via Amazon Payments")
    }
    
    func fulfilledTransactions() -> Double {
        return payments
    }
}


let amazonPayments = AmazonPayments()
amazonPayments.paid(value: 120, currency: "USD")
amazonPayments.paid(value: 74.99, currency: "USD")

class AmazonPaymentsAdapter: PaymentGateway {
    func receivePayment(amount: Double) {
        amazonPayments.paid(value: amount, currency: "USD")
    }
    
    var totalPayments: Double {
        let total = amazonPayments.payments
        print("Total payments received via Amazon Payments: \(total)")
        return total
    }
}

let amazonPaymentsAdapter = AmazonPaymentsAdapter()
amazonPaymentsAdapter.receivePayment(amount: 120)
amazonPaymentsAdapter.receivePayment(amount: 74.99)

paymentGateways.append(amazonPaymentsAdapter)

var total = 0.0
for gateway in paymentGateways {
    total += gateway.totalPayments
}

print(total)

// END: Adapter design pattern


// START: Decorator design pattern

class UserDefaultsDecorator: UserDefaults {
    private var userDefaults = UserDefaults.standard
    
    convenience init(userDefaults: UserDefaults) {
        self.init()
        self.userDefaults = userDefaults
    }
    
    func set(date: Date?, forKey key: String) {
        userDefaults.set(date, forKey: key)
    }
    
    func date(forKey key: String) -> Date? {
        return userDefaults.value(forKey: key) as? Date
    }
}

let userDefaults = UserDefaultsDecorator()

userDefaults.set(42, forKey: "the answer")
print(userDefaults.string(forKey: "the answer") ?? "?")

userDefaults.set(date: Date(), forKey: "now")

// END: Decorator design pattern


//START: Prototype design pattern

class NameClass: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return NameClass(firstName: self.firstName, lastName: self.lastName)
    }
    
    func clone() -> NameClass {
        return self.copy() as! NameClass
    }
    
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension NameClass: CustomStringConvertible {
    public var description: String {
        return "NameClass(firstName: \"\(firstName)\", lastName: \"\(lastName)\")"
    }
}

var steve = NameClass(firstName: "Steve", lastName: "Johnson")
var john = steve.clone()

print("\(steve), \(john)")

john.firstName = "John"
john.lastName = "Wallace"

print("\(steve), \(john)")


// END:  Prototype design pattern


//START: Fly weight design pattern

class SharedSpaceShipData {
    private let mesh: [Float]
    private let texture: UIImage?

    init(mesh: [Float], imageNamed name: String) {
        self.mesh = mesh
        self.texture = UIImage(named: name)
    }
}

class SpaceShip {
    private var position: (Float, Float, Float)
    private var intrinsicState: SharedSpaceShipData

    init(sharedData: SharedSpaceShipData, position: (Float, Float, Float) = (0, 0, 0)) {
        self.position = position
        self.intrinsicState = sharedData
    }
}



let fleetSize = 1000
var ships = [SpaceShip]()
var vertices = [Float](repeating: 0, count: 1000) // just a dummy array of floats

let sharedState = SharedSpaceShipData(mesh: vertices, imageNamed: "SpaceShip")

for _ in 0..<fleetSize {
    let ship = SpaceShip(sharedData: sharedState,
                         position: (Float.random(in: 1...100),
                                    Float.random(in: 1...100),
                                    Float.random(in: 1...100)))
    ships.append(ship)
}

// END: Fly weight design pattern




//START: Proxy design pattern

class RandomIntWithID {
    var value: Int = {
        print("value initialized")
        return Int.random(in: Int.min...Int.max)
    }()
    
    lazy var uid: String = {
        print("uid initialized")
        return UUID().uuidString
    }()
}

let n = RandomIntWithID()
print(n.uid)



//END: Proxy design pattern
