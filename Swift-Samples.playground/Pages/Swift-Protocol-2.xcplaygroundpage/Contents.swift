

//: 1 - Create a protocol `Area` that defines a read-only property `area` of type `Double`.
protocol Area {
  var area: Double { get }
}
//: 2. Implement `Area` with structs representing `Square`, `Triangle`, and `Circle`.
struct Square: Area {
  let side: Double
  
  var area: Double {
    side * side
  }
}

struct Triangle: Area {
  let base: Double
  let height: Double
  
  var area: Double  {
    0.5 * base * height
  }
}

struct Circle: Area {
  let radius: Double
  
  var area: Double  {
    .pi * radius * radius
  }
}
//: 3. Add a circle, square, and triangle to an array. Convert the array of shapes to an array of areas using `map`.
let square = Square(side: 4)
let triangle = Triangle(base: 3, height: 5)
let circle = Circle(radius: 2)
let shapes: [Area] = [square, triangle, circle]
print(shapes.map { $0.area })
