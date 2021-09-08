//
//  Contacts.swift
//  DemoProject
//
//  Created by Admin on 08/09/21.
//

import Foundation
import RealmSwift

class Contact: Object {
    @Persisted var name = ""
    @Persisted var Phone = ""
}
