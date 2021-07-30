struct FuelTank {

  var lowFuel: Bool
  var level: Double { // decimal percentage between 0 and 1
    didSet {
      if level < 0 {
        level = 0
      }
      if level > 1 {
        level = 1
      }
      lowFuel = level < 0.1
    }
  }
}

struct Car {
  let make: String
  let color: String
  var tank: FuelTank
}

var car = Car(make: "DeLorean", color: "Silver", tank: FuelTank(lowFuel: false, level: 1))
car.tank.level = -1 // level: 0, lowFuel: true
car.tank.level = 1.1 // level: 1, lowFuel: false
