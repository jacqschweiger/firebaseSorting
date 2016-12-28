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
    
    let ref = FIRDatabase.database().reference(withPath: "profile_names")
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func adjustDataPressed(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            sortAToZ()
        case 1:
            sortZToA()
        case 2:
            print("filter pressed")
        default:
            print("error")
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        createAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observe(.value, with: { snapshot in
            var newProfiles: [Profile] = []
            
            for profile in snapshot.children {
                
                let newProfile = Profile(snapshot: profile as! FIRDataSnapshot)
                newProfiles.append(newProfile)
            }
            
            self.profiles = newProfiles
            self.tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let profile = profiles[indexPath.row]
            profile.ref?.removeValue()
        }
    }
    
    func createAlert(){
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
    }
    
    func sortAToZ() {
        self.profiles.sort { (profile1, profile2) -> Bool in
            profile1.name < profile2.name
        }
        
        self.tableView.reloadData()
    }
    
    func sortZToA() {
        self.profiles.sort { (profile1, profile2) -> Bool in
            profile1.name > profile2.name
        }
        
        self.tableView.reloadData()
    }

}

