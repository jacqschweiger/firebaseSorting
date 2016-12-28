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
    var userID: Int
    var name: String
    var age: Int
    
    init(key: String = "", userID: Int, name: String, age: Int) {
        self.key = key
        self.userID = userID
        self.name = name
        self.age = age
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        age = snapshotValue["age"] as! Int
        userID = snapshotValue["userID"] as! Int
        ref = snapshot.ref
    }
    
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "age": age
        ]
    }
    
}
