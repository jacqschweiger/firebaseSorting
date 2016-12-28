//
//  DetailViewController.swift
//  firebaseProject
//
//  Created by Jacqueline Minneman on 12/15/16.
//  Copyright © 2016 Jacqueline Minneman. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var profile: Profile!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let profile = profile else { return }
        
        nameLabel.text = profile.name
        ageLabel.text = "Age \(profile.age)"
    }
    
    
    
}