//
//  ViewController.swift
//  DemoProject
//
//  Created by Admin on 07/09/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    var dogs: Results<Dog>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL as Any)
        print(realm.objects(Dog.self))
    }
    
    func create() {
        try! realm.write {
            let somedog = Dog()
            somedog.breed = "german shepherd"
            somedog.color = "gray"
            realm.add(somedog)
            
            let someOtherDog = Dog()
            someOtherDog.breed = "golden retriever"
            someOtherDog.color = "golden"
            realm.add(someOtherDog)
        }
    }
    
    func read() {
        dogs =  realm.objects(Dog.self).filter("color == 'brown'")
        print(dogs as Any)
    }
    
    func update() {
        try! realm.write {
            dogs[0].color = "red"
        }
    }
    
    func delete() {
        try! realm.write {
            realm.delete(dogs)
        }
    }
}
