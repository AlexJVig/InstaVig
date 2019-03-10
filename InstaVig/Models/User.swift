//
//  User.swift
//  InstaVig
//
//  Created by Alex Vig on 09/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import Foundation
import Firebase;

class User {
    
    let id:String
    let fullName:String
    let profilePicture:String
    let description:String
    var lastUpdate:Double?
    
    init(_id:String, _fullName:String, _description:String = "", _profilePicture:String = "", _lastUpdate:Double? = nil){
        id = _id
        fullName = _fullName
        profilePicture = _profilePicture
        description = _description
        lastUpdate = _lastUpdate
    }
    
    init(json:[String:Any]) {
        id = json["id"] as! String
        fullName = json["name"] as! String
        description = json["about"] as! String
        
        if json["image"] != nil{
            profilePicture = json["image"] as! String
        }else{
            profilePicture = ""
        }
        if json["lastUpdate"] != nil {
            if let lud = json["lastUpdate"] as? Double{
                lastUpdate = lud
            }
        }
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["name"] = fullName
        json["about"] = description
        json["image"] = profilePicture
        json["lastUpdate"] = ServerValue.timestamp()
        return json
    }
    
}

