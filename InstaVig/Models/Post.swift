//
//  Post.swift
//  InstaVig
//
//  Created by Alex Vig on 09/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import Foundation
import Firebase;

class Post {
    
    let id:String
    let text:String
    let userId:String
    let imageUrl:String
    var isDeleted:Int
    var lastUpdate:Double?
    
    init(_id:String, _text:String, _userId:String, _imageUrl:String = "", _lastUpdate:Double? = nil, _isDeleted: Int = 0){
        id = _id
        text = _text
        userId = _userId
        imageUrl = _imageUrl
        lastUpdate = _lastUpdate
        isDeleted = _isDeleted
    }
    
    init(json:[String:Any]) {
        id = json["id"] as! String
        text = json["text"] as! String
        userId = json["userId"] as! String
        isDeleted = json["isDeleted"] as! Int
        imageUrl = json["imageUrl"] as! String
        lastUpdate = json["lastUpdate"] as! Double
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["text"] = text
        json["userId"] = userId
        json["imageUrl"] = imageUrl
        json["lastUpdate"] = ServerValue.timestamp()
        json["isDeleted"] = isDeleted
        return json
    }
    
}
