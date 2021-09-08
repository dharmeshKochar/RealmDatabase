//
//  Task.swift
//  DemoProject
//
//  Created by Admin on 08/09/21.
//

import Foundation
import RealmSwift

class Task: Object {
    @Persisted var task = ""
}
