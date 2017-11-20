//
//  main.swift
//  AnimalShelter
//
//  Created by Emiko Clark on 11/18/17.
//  Copyright © 2017 Emiko Clark. All rights reserved.
//

import Foundation

class Animal {
    var animalType: String
    var arrivalTime: Int
    var next: Animal?
    
    init(arrivalTime: Int) {
        self.arrivalTime = arrivalTime
        self.animalType = ""
    }
}

class Cat: Animal {
    override init(arrivalTime: Int) {
        super.init(arrivalTime: arrivalTime)
        self.animalType = "Cat"
        self.arrivalTime = arrivalTime
    }
}

class Dog: Animal {
    override init(arrivalTime: Int) {
        super.init(arrivalTime: arrivalTime)
        self.animalType = "Dog"
        self.arrivalTime = arrivalTime
    }
}

class Queue {
    
    var front: Animal?
    var rear: Animal?

    func isEmpty() -> Bool {
        return front == nil ? true : false
    }
    
    func printQueue(queue: Queue) {
        var output = "----------\n"
        var n = queue.front

        while(n?.next != nil && n != nil) {
            output += "\(String(describing: (n?.animalType)!)), \(String(describing: (n?.arrivalTime)!))\n"
            n = n?.next
        }
        if (n?.animalType != nil) {
            output += "\(String(describing: (n?.animalType)!)), \(String(describing: (n?.arrivalTime)!))\n"
        }
        output += "----------\n"
        print(output)
    }
}


class AnimalShelter {
    var catQueue = Queue()
    var dogQueue = Queue()
    
    init() {
        initializeCat(cat: catQueue)
        initializeDog(dog: dogQueue)
    }
    
    func initializeCat(cat: Queue) {
        catQueue.front = catQueue.rear
        let c1 = Cat(arrivalTime: 123)
        let c2 = Cat(arrivalTime: 240)
        let c3 = Cat(arrivalTime: 300)
        enqueueCat(animal: c1)
        enqueueCat(animal: c2)
        enqueueCat(animal: c3)
        catQueue.printQueue(queue: cat)
    }
    
    func initializeDog(dog: Queue) {
        dogQueue.front = dogQueue.rear
        
        let d1 = Dog(arrivalTime: 230)
        let d2 = Dog(arrivalTime: 260)
        let d3 = Dog(arrivalTime: 350)
        enqueueDog(animal: d1)
        enqueueDog(animal: d2)
        enqueueDog(animal: d3)
        dogQueue.printQueue(queue: dog)
    }
    
    func enqueueCat(animal: Cat) {
        if catQueue.rear != nil {
            catQueue.rear?.next = animal
        }
        catQueue.rear = animal
        
        if catQueue.front == nil {
            catQueue.front = animal
            catQueue.front = catQueue.rear
        }
    }
    
    func dequeueCat() -> Cat {
        let nextCat = catQueue.front
        catQueue.front = catQueue.front?.next

        let nextCatAT = nextCat?.arrivalTime
        print("\ndequeued Cat: \(nextCatAT!)")
        
        if catQueue.isEmpty() {
            print("No more cats in Queue")
            catQueue.rear = nil
        }
        catQueue.printQueue(queue: catQueue)
        return nextCat! as! Cat
    }

    func enqueueDog(animal: Dog) {
        if dogQueue.rear != nil {
            dogQueue.rear?.next = animal
        }
        dogQueue.rear = animal
        
        if dogQueue.front == nil {
            dogQueue.front = animal
            dogQueue.front = dogQueue.rear
        }
    }
    
    func dequeueDog() -> Dog {
        
        let nextDog = dogQueue.front
        dogQueue.front = dogQueue.front?.next
        
        let nextDogAT = nextDog?.arrivalTime
        print("\ndequeued Dog: \(nextDogAT!)")
        
        if dogQueue.isEmpty() {
            print("No more dogs in Queue")
            dogQueue.rear = nil
        }
        
        dogQueue.printQueue(queue: dogQueue)
        return nextDog! as! Dog
    }
    
    func dequeueAny(queue: AnimalShelter) -> Animal {
        var nextPet = Animal(arrivalTime: 0)
        
        if queue.catQueue.isEmpty() && queue.dogQueue.isEmpty() {
            print("No more cats or dogs in Queue")
        }
        
        else if queue.catQueue.isEmpty() && !queue.dogQueue.isEmpty(){
            print("No more cats in Queue")
            nextPet = queue.dequeueDog()
        }
        
        else if queue.dogQueue.isEmpty() && !queue.catQueue.isEmpty(){
            print("No more dogs in Queue")
            nextPet = queue.dequeueCat()
        }
        
        else {
            // check front Animal on cat and dog queue find and return Animal with minimum time between the two
            nextPet = (queue.catQueue.front?.arrivalTime)! < (queue.dogQueue.front?.arrivalTime)! ? queue.catQueue.front! : queue.dogQueue.front!
            if nextPet.animalType == "Cat" {
                // dequeue cat
                nextPet = animalShelter.dequeueCat()
            } else if nextPet.animalType == "Dog" {
                // dequeue dog
                nextPet = animalShelter.dequeueDog()
            }
        }
        return nextPet
    }
}

var animalShelter = AnimalShelter()
var nextPet = animalShelter.dequeueAny(queue: animalShelter)
print("next PET requested, arrival time is \(String(describing: nextPet.animalType)), arrived at: \(nextPet.arrivalTime)")
nextPet = animalShelter.dequeueAny(queue: animalShelter)
print("next PET requested, arrival time is \(String(describing: nextPet.animalType)), arrived at: \(nextPet.arrivalTime)")

let nextCat = animalShelter.dequeueCat()
print("Next cat requested, arrival time is: \(nextCat.arrivalTime)")

let nextDog = animalShelter.dequeueDog()
print("Next dog requested, arrival time is: \(nextDog.arrivalTime)")

let c1 = Cat(arrivalTime: 500)
animalShelter.enqueueCat(animal: c1)
animalShelter.catQueue.printQueue(queue: animalShelter.catQueue)

let nextAny1 = animalShelter.dequeueAny(queue: animalShelter)
print("next PET1 requested, arrival time is \(String(describing: nextAny1.animalType)), arrived at: \(nextAny1.arrivalTime)\n")

let nextAny2 = animalShelter.dequeueAny(queue: animalShelter)
print("next PET2 requested, arrival time is \(String(describing: nextAny2.animalType)), arrived at: \(nextAny2.arrivalTime)\n")

let nextAny3 = animalShelter.dequeueAny(queue: animalShelter)
if nextAny3.animalType == "" {
    print("No more pets in Shelter")
} else {
    print("Next PET3 requested, arrival time is \(String(describing: nextAny3.animalType)), arrived at: \(nextAny3.arrivalTime)\n")
}

let nextAny4 = animalShelter.dequeueAny(queue: animalShelter)
if nextAny4.animalType == "" {
    print("No more pets in Shelter")
} else {
    print("Next PET4 requested, arrival time is \(String(describing: nextAny4.animalType)), arrived at: \(nextAny4.arrivalTime)")
}

let nextCat2 = animalShelter.dequeueAny(queue: animalShelter)
if nextCat2.animalType == "" {
    print("No more cats in Shelter")
} else {
    print("Next nextCat requested, arrival time is \(String(describing: nextCat2.animalType)), arrived at: \(nextCat2.arrivalTime)")
}
