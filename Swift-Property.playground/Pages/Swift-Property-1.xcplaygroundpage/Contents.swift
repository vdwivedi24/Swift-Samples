import UIKit

struct LightBulb {
  static let maxCurrent = 40
  var isOn = false
  var current = LightBulb.maxCurrent {
    willSet { // can observe the newValue, but can't change it
      if newValue > Self.maxCurrent {
        print("Current is too high, turning off to prevent burn out.")
        isOn = false
      }
    }
    didSet {
      if current > Self.maxCurrent {
        print("Current is too high, falling back to previous setting.")
        current = oldValue
      }
    }
  }
}

// Installing a new bulb
var bulb = LightBulb() // Light bulb is off

// Flipping the switch
bulb.isOn = true // Light bulb is ON with 40 amps

// Using the dimmer
bulb.current = 30 // Light bulb is ON with 30 amps

// Using the dimmer to a high value
bulb.current = 50 // Light bulb is OFF

// Flipping the switch
bulb.isOn = true // Light bulb is ON with 30 amps
