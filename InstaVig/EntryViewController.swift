//
//  EntryViewController.swift
//  InstaVig
//
//  Created by Alex Vig on 09/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import UIKit
import Firebase

class EntryViewController: UIViewController {

    @IBOutlet weak var emailOutlet: UITextField!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func returnToLoginViewController(_ segue: UIStoryboardSegue) { }
    
    @IBAction func loginAttempt(_ sender: Any) {
        let email = emailOutlet.text ?? ""
        let password = passwordOutlet.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            //let uid = Auth.auth().currentUser!.uid
        }
        
        performSegue(withIdentifier: "loginSucceeded", sender: self)
    }
}
