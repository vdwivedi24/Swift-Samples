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




