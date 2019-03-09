//
//  DBModel.swift
//  InstaVig
//
//  Created by Alex Vig on 09/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DBModel {
    var ref: DatabaseReference!
    
    var postsReference: DatabaseReference?
    var postsObserver: DatabaseHandle?
    var userReference: DatabaseReference?
    var userObserver: DatabaseHandle?
    
    init() {
        FirebaseApp.configure()
        ref = Database.database().reference()
    }
    
    func removeObservers() {
        postsReference?.removeObserver(withHandle: postsObserver!)
        userReference?.removeObserver(withHandle: userObserver!)
    }
    
    // ---- POSTS ----
    
    func addNewPost(post:Post) {
        
    }
    
    func deletePost(post:Post) {
        
    }
    
    func observePosts(from:Double, callback:@escaping ([Post])->Void){
        
    }
    
    // --- USERS ----
    
    func observeUser(userId: String, callback: @escaping (User)->Void) {
        
    }
    
    func signin(email:String, password:String, callback:@escaping (Bool)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (user != nil){
                //user?.user.uid
                callback(true)
            }else{
                callback(false)
            }
        }
        
    }
    
    func updateUser(user: User) {
        ref.child("users").child(user.id).setValue(user.toJson())
    }
    
    func createUser(email:String, password:String, name:String, callback:@escaping (Bool)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let userId = authResult?.user.uid {
                let user = User(_id: userId, _name: name)
                self.updateUser(user: user)
                callback (true)
            } else {
                callback (false)
            }
        }
    }
    
}
