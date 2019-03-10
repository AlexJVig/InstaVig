//
//  RegistrationViewController.swift
//  InstaVig
//
//  Created by Alex Vig on 09/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
    
    @IBAction func onRegister(_ sender: Any) {
        if (fullNameOutlet.text?.isEmpty ?? true || emailOutlet.text?.isEmpty ?? true || passwordOutlet.text?.isEmpty ?? true || verifyOutlet.text?.isEmpty ?? true)
        {
            Utilities.showAlert("Please fill all the details", self)
        }
        else if (passwordOutlet.text != verifyOutlet.text)
        {
            Utilities.showAlert("Passwords do not match", self)
        }
        else {
            Utilities.showSpinner(onView: self.view)
            
            let user = User(_id: "", _fullName: fullNameOutlet.text ?? "", _description: "", _profilePicture: "", _lastUpdate: 0)
            
            self.ref.child("users").childByAutoId().setValue(user.toJson())
            
            Utilities.removeSpinner()
            
            dismiss(animated: true, completion: nil)
        }
    }
    
}
