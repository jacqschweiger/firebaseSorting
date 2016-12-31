//
//  DetailViewController.swift
//  firebaseProject
//
//  Created by Jacqueline Minneman on 12/15/16.
//  Copyright © 2016 Jacqueline Minneman. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let storage = FIRStorage.storage()
    var profile: Profile!
    var hobbies: String?
    let picker = UIImagePickerController()
    let ref = FIRDatabase.database().reference(withPath: "profile_names")
    
    @IBOutlet weak var hobbiesTextField: UITextField!
    
    //TODO: use button to enable editing in text field, save text into Firebase
    @IBAction func addHobbies(_ sender: Any) {
        hobbiesTextField.isEnabled = true
        hobbies = hobbiesTextField.text
        
        if !hobbiesTextField.isEditing {
        ref.child("hobbies").setValue(hobbies)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var hobbiesText: UILabel!
    
    
    @IBAction func photoFromLibrary(_ sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.barButtonItem = sender
    }
    
    @IBAction func shootPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        picker.delegate = self
        hobbiesTextField.isEnabled = false
        
        guard let profile = profile else { return }
        
        nameLabel.text = profile.name
        ageLabel.text = "Age \(profile.age)"
    }
    
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    
    //MARK: - Delegates
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = chosenImage
                
        dismiss(animated:true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    
}
