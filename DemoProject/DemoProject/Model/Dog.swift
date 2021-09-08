//
//  Dog.swift
//  DemoProject
//
//  Created by Admin on 08/09/21.
//

import Foundation
import RealmSwift

class Dog: Object{
    @Persisted var color = ""
    @Persisted var breed = ""
}
