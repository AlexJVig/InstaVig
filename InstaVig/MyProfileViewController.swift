//
//  MyProfileViewController.swift
//  InstaVig
//
//  Created by Alex Vig on 10/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MyProfileViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func backToMyProfile(_ segue: UIStoryboardSegue) { }
    
    @IBAction func logout(_ sender: Any) {
    do {
        try Auth.auth().signOut()
    } catch {
    print ("Error signing out: %@")
    }
        performSegue(withIdentifier: "BackToEntry", sender: self)
    }
}
