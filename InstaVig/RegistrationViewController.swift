//
//  RegistrationViewController.swift
//  InstaVig
//
//  Created by Alex Vig on 09/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var fullNameOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var verifyOutlet: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func register(_ sender: Any) {
        let fullNameText = fullNameOutlet.text ?? ""
        let passwordText = passwordOutlet.text ?? ""
        let emailText = emailOutlet.text ?? ""
        
        if (fullNameText == "" || emailText == "" || passwordText == "" || verifyOutlet.text?.isEmpty ?? true)
        {
            Utilities.showAlert("Please fill all the details", self)
        }
        else if (passwordOutlet.text != verifyOutlet.text)
        {
            Utilities.showAlert("Passwords do not match", self)
        }
        else {
            Utilities.showSpinner(onView: self.view)
            
            //let user = User(_id: "", _fullName: fullNameOutlet.text ?? "", _description: "", _profilePicture: "", _lastUpdate: 0)
            
            //self.ref.child("users").childByAutoId().setValue(user.toJson())
            
            Auth.auth().createUser(withEmail: emailText, password: passwordText) { authResult, error in
                if let userId = authResult?.user.uid {
                    let user = User(_id: userId, _fullName: fullNameText, _description: "", _profilePicture: "", _lastUpdate: 0)
                    
                    self.ref.child("users").childByAutoId().setValue(user.toJson())
                } else {
                    Utilities.showAlert("User creation has failed!", self)
                }
            }
            
            Utilities.removeSpinner()
            dismiss(animated: true, completion: nil)
        }
    }
    
}
