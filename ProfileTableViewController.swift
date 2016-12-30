//
//  ProfileTableViewController.swift
//  firebaseProject
//
//  Created by Jacqueline Minneman on 12/15/16.
//  Copyright © 2016 Jacqueline Minneman. All rights reserved.
//

import UIKit
import Firebase

//TODO: filter by gender, automatically create new userID & sort by userID as default, add camera capability, add editing capability

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
            showFemales()
        case 3:
            showMales()
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
        cell.detailTextLabel?.text = profiles[indexPath.row].gender
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
        let alert = UIAlertController(title: "Profile", message: "Add New Profile", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            guard let textField1 = alert.textFields?[0], let nameText = textField1.text else { return }
            
            guard let textField2 = alert.textFields?[1], let ageText = textField2.text else { return }
            
            guard let textField3 = alert.textFields?[2], let genderText = textField3.text else { return }
            
            let profile = Profile(name: nameText, age: Int(ageText)!, gender: genderText)
            
//            let profileIDRef = self.ref.childByAutoId()
//            
//            let profileIDKey = profileIDRef.key
//            
//            print("\n\n\n\n\n///////this is the profileIDKey: \(profileIDKey)////////////\n\n\n")
            
            let profileRef = self.ref.child(nameText.lowercased())
            
            profileRef.setValue(profile.toAnyObject())
            
        }
        
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter First Name"
        }
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Age"
        }
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Gender: M/F"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func sortAToZ() {
        ref.queryOrdered(byChild: "name").observe(.value, with: { (snapshot) in
            print("printing snapshot: \(snapshot)")
            
            var newProfiles: [Profile] = []
            
            for profile in snapshot.children {
                
                let newProfile = Profile(snapshot: profile as! FIRDataSnapshot)
                newProfiles.append(newProfile)
            }
            
            self.profiles = newProfiles
            self.tableView.reloadData()
        })
        
    }
    
    func sortZToA() {
        ref.queryOrdered(byChild: "name").observe(.value, with: { (snapshot) in
            print("printing snapshot: \(snapshot)")
            
            var newProfiles: [Profile] = []
            
            for profile in snapshot.children {
                
                let newProfile = Profile(snapshot: profile as! FIRDataSnapshot)
                newProfiles.append(newProfile)
            }
            
            self.profiles = newProfiles.reversed()
            self.tableView.reloadData()
        })
    }
    
    func showFemales(){
        
        ref.queryOrdered(byChild: "gender").queryEqual(toValue: "F").observe(.value, with: { (snapshot) in
            
            var femaleProfiles: [Profile] = []
            
            for female in snapshot.children {
                print("female: \(female)")
                let femaleProfile = Profile(snapshot: female as! FIRDataSnapshot)
                femaleProfiles.append(femaleProfile)
            }
            
            self.profiles = femaleProfiles
            self.tableView.reloadData()
        })
    }
    
    func showMales(){
        
        ref.queryOrdered(byChild: "gender").queryEqual(toValue: "M").observe(.value, with: { (snapshot) in
            
            var maleProfiles: [Profile] = []
            
            for male in snapshot.children {
                print("male: \(male)")
                let maleProfile = Profile(snapshot: male as! FIRDataSnapshot)
                maleProfiles.append(maleProfile)
            }
            
            self.profiles = maleProfiles
            self.tableView.reloadData()
        })
    }
    
    
    
    //TODO: get integer IDs
    func getIDs() {
        
        print("/////////get ids called//////////////\n\n\n")
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if let result = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for profile in result {
                    let id = profile.key
                    print("///////printing ids: \(id) ///////")
                }
            }
        })
    }
    
}

