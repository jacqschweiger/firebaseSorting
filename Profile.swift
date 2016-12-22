//
//  Profile.swift
//  firebaseProject
//
//  Created by Jacqueline Minneman on 12/15/16.
//  Copyright © 2016 Jacqueline Minneman. All rights reserved.
//

import Foundation
import UIKit

class Profile {
    
    var userID: Int
    var backgroundColor: UIColor?
    var gender: String
    var name: String
    var age: Int
    var profileImage: UIImage
    var hobbies: String
    
    init(userID: Int, gender: String, name: String, age: Int, profileImage: UIImage, hobbies: String) {
        self.userID = userID
        self.gender = gender
        self.name = name
        self.age = age
        self.profileImage = profileImage
        self.hobbies = hobbies
        
        switch gender {
        case "male": self.backgroundColor = UIColor.blue
        case "female": self.backgroundColor = UIColor.green
        default: self.backgroundColor = UIColor.white
        }
    }
    
}
