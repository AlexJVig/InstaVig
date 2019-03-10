//
//  MyProfileViewController.swift
//  InstaVig
//
//  Created by Alex Vig on 10/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyProfileViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func backToMyProfile(_ segue: UIStoryboardSegue) { }
    
}
