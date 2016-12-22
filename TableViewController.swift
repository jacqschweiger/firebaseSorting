//
//  TableViewController.swift
//  firebaseProject
//
//  Created by Jacqueline Minneman on 12/15/16.
//  Copyright © 2016 Jacqueline Minneman. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var profiles = [Profile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createProfiles()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath) //as! TableViewCell
        cell.textLabel?.text = profiles[indexPath.row].name
        cell.backgroundColor = profiles[indexPath.row].backgroundColor
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destVC = segue.destination as? ProfileViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destVC.profile = profiles[indexPath.row]
                }
            }
        }
    }
    
    
    func createProfiles(){
        let profile1 = Profile(userID: 111, gender: "female", name: "Lucy", age: 7, profileImage: #imageLiteral(resourceName: "puppy"), hobbies: ["barking", "playing"])
        let profile2 = Profile(userID: 112, gender: "male", name: "Buddy", age: 5, profileImage: #imageLiteral(resourceName: "puppy"), hobbies: ["barking", "playing"])
        let profile3 = Profile(userID: 113, gender: "female", name: "Ruby", age: 3, profileImage: #imageLiteral(resourceName: "puppy"), hobbies: ["barking", "playing", "eating"])
        
        profiles = [profile1, profile2, profile3]
    }
    
    
    
    
    
    
}

