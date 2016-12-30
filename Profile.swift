//
//  Profile.swift
//  firebaseProject
//
//  Created by Jacqueline Minneman on 12/15/16.
//  Copyright © 2016 Jacqueline Minneman. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Profile {
    
    let key: String
    let ref: FIRDatabaseReference?
    var name: String
    var age: Int
    var gender: String
    
    init(key: String = "", name: String, age: Int, gender: String) {
        self.key = key
        self.name = name
        self.age = age
        self.gender = gender
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        age = snapshotValue["age"] as! Int
        gender = snapshotValue["gender"] as! String
        ref = snapshot.ref
    }
    
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "age": age,
            "gender": gender
        ]
    }
    
}
