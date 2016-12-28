//
//  ProfileTableViewController.swift
//  firebaseProject
//
//  Created by Jacqueline Minneman on 12/15/16.
//  Copyright © 2016 Jacqueline Minneman. All rights reserved.
//

import UIKit
import Firebase

class ProfileTableViewController: UITableViewController {
    
    var profiles = [Profile]()

    let ref = FIRDatabase.database().reference()
    
    @IBAction func addButtonTapped(_ sender: Any) {
        print("add button tapped")
        let alert = UIAlertController(title: "Profile",
                                      message: "Add New Profile",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { _ in
                                        // 1
                                        guard let textField = alert.textFields?.first,
                                            let text = textField.text else { return }
                                        
                                        // 2
                                        let profile = Profile(userID: 123, name: text, age: 10)
                                        
                                        // 3
                                        let profileRef = self.ref.child(text.lowercased())
                                        
                                        // 4
                                        profileRef.setValue(profile.toAnyObject())
                                        print("save pressed")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        print("end of add button tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        createProfiles()
        
        ref.observe(.value, with: { snapshot in
            print(snapshot.value)
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        
        cell.textLabel?.text = profiles[indexPath.row].name
        cell.detailTextLabel?.text = "ID: \(profiles[indexPath.row].userID)"
        cell.backgroundColor = UIColor(red: 0/255, green: 214/255, blue: 203/255, alpha: 1.0)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destVC = segue.destination as? DetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destVC.profile = profiles[indexPath.row]
                }
            }
        }
    }
    
    
    func createProfiles(){
        let profile1 = Profile(userID: 111, name: "Lucy", age: 7)
        let profile2 = Profile(userID: 112, name: "Buddy", age: 5)
        let profile3 = Profile(userID: 113, name: "Ruby", age: 3)
        
        profiles = [profile1, profile2, profile3]
    }
    
    
    
    
    
    
}

