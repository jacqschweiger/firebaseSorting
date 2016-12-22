//
//  ProfileViewController.swift
//  firebaseProject
//
//  Created by Jacqueline Minneman on 12/15/16.
//  Copyright © 2016 Jacqueline Minneman. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    var profile: Profile!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let profile = profile else { return }
        nameLabel.text = profile.name
        
    }
    
    
    
}
