//
//  FirebaseModel.swift
//  InstaVig
//
//  Created by Alex Vig on 09/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseModel {
    
    static let instance:FirebaseModel = FirebaseModel()
    
    func createUser(email:String, password:String, name:String, callback:@escaping (Bool)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let userId = authResult?.user.uid {
                let user = User(_id: userId, _name: name)
                //self.updateUser(user: user)
                callback (true)
            }else{
                callback (false)
            }
        }
    }
    
}
