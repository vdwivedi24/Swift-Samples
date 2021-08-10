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




