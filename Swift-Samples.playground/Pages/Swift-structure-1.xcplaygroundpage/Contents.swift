import Foundation

struct Pizza {
  let size: Int // Inches
  let toppings: [String] // Pepperoni, cheese
  let style: String // Thick, thin, hand-tossed
}

let pizza = Pizza(size: 14, toppings: ["Pepperoni", "Mushrooms", "Anchovies"], style: "Thin")

struct Location {
  let x: Int
  let y: Int
}

func distance(from source: Location, to target: Location) -> Double {
  let distanceX = Double(source.x - target.x)
  let distanceY = Double(source.y - target.y)
  return sqrt(distanceX * distanceX + distanceY * distanceY)
}

struct DeliveryArea {
  let center: Location
  var radius: Double
  
  func contains(_ location: Location) -> Bool {
    distance(from: center, to: location) < radius
  }
  
  func overlaps(with area: DeliveryArea) -> Bool {
    distance(from: center, to: area.center) <= (radius + area.radius)
  }
}

let area1 = DeliveryArea(center: Location(x: 3, y: 4), radius: 2.5)
let area2 = DeliveryArea(center: Location(x: 7, y: 8), radius: 2.5)
area1.overlaps(with: area2) // false

let area3 = DeliveryArea(center: Location(x: 3, y: 4), radius: 2.5)
let area4 = DeliveryArea(center: Location(x: 7, y: 7), radius: 2.5)
area3.overlaps(with: area4) // true
