

import Foundation
//: Pet shop tasks
//:
//: Create a collection of protocols for tasks that need doing at a pet shop. The pet shop has dogs, cats, fish and birds.
//: The pet shop duties include these tasks:
//:
//: * All pets need to be fed.
//:
//: * Pets that can fly need to be caged.
//:
//: * Pets that can swim need a tank.
//:
//: * Pets that walk need exercise.
//:
//: * Tanks, cages, and litter boxes need to be cleanded occasionally.
//:

//: 1. Create classes or structs for each animal and adopt the appropriate protocols. Feel free to simply use a print() statement for the method implementations.

protocol Feedable {
  func feed()
}

protocol Cleanable {
  func clean()
}

protocol Cageable: Cleanable {
  func cage()
}

protocol Tankable: Cleanable {
  func tank()
}

protocol Walkable {
  func walk()
}

class Dog: Feedable, Walkable {
  func feed() {
    print("Woof...thanks!")
  }

  func walk() {
    print("Walk the dog")
  }
}

class Cat: Feedable, Cleanable {
  func feed() {
    print("Yummy meow")
  }

  func clean() {
    print("Litter box cleaned")
  }
}

class Fish: Feedable, Tankable {
  func feed() {
    print("Fish goes blub")
  }

  func tank() {
    print("Fish has been tanked")
  }

  func clean() {
    print("Fish tank has been cleaned")
  }
}

class Bird: Feedable, Cageable {
  func feed() {
    print("Tweet!")
  }

  func cage() {
    print("Cage the bird")
  }

  func clean() {
    print("Clean the cage")
  }
}

//: 2. Create homogenous arrays for animals that need to be fed, caged, cleaned, walked, and tanked. Add the appropriate animals to these arrays. The arrays should be declared using the protocol as the element type, for example `var caged: [Cageable]`.

let dog = Dog()
let cat = Cat()
let fish = Fish()
let bird = Bird()

let walkingDuties: [Walkable] = [dog]
let feedingDuties: [Feedable] = [dog, cat, fish, bird]
let tankingDuties: [Tankable] = [fish]
let cagingDuties: [Cageable] = [bird]
let cleaningDuties: [Cleanable] = [cat, fish, bird]

// Swift's type system prevents you from adding something that
// can't be walked to a homogenous list of `Walkable`!
// let invalidWalkingDuties: [Walkable] = [dog, fish]

//: 3. Write a loop that will perform the proper tasks (such as feed, cage, walk) on each element of each array.

for walkable in walkingDuties {
  walkable.walk()
}

for feedable in feedingDuties {
  feedable.feed()
}

for tankable in tankingDuties {
  tankable.tank()
}

for cageable in cagingDuties {
  cageable.cage()
}

for cleanable in cleaningDuties {
  cleanable.clean()
}
