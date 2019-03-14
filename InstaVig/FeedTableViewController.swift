//
//  FeedTableViewController.swift
//  InstaVig
//
//  Created by Alex Vig on 13/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import UIKit
import Firebase

class FeedTableViewController: UITableViewController {
    
    var ref: DatabaseReference!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        let postRef = ref.child("posts")
        
        
        let refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            
            for (_, post) in postDict {
                let postData = post as! [String : Any]
                
                self.posts.append(Post(_id: postData["id"] as! String, _text: postData["text"] as! String, _userId: postData["userId"] as! String))
            }
            
            self.tableView.reloadData()
        })
    }
    
    private func observePosts() -> [Post] {
        var posts = [Post]()
        ref = Database.database().reference() // ***
        let postRef = ref.child("posts")
        let refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            
            for (_, post) in postDict {
                let postData = post as! [String : Any]
                
                posts.append(Post(_id: postData["id"] as! String, _text: postData["text"] as! String, _userId: postData["userId"] as! String))
            }
        })
        
        return posts
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row]
        let islandRef = Storage.storage().reference(withPath: "images/" + post.id + ".jpg")
        
        cell.bodyOutlet?.text = post.text
        cell.fullNameOutlet?.text = post.userId
        
        islandRef.getData(maxSize: 1 * 4096 * 4096) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                cell.imageOutlet.image = UIImage(data: data!)
            }
        }
        
        //let profilePicRef = Storage.storage().reference(withPath: "images/" + post.id + ".jpg")
        
        //ref.child("users").child("-L_mB7DCo3XN-LcTTkVS").observeSingleEvent(of: .value, with: { (snapshot) in
        //    let value = snapshot.value as? NSDictionary
        //    let id = value?["id"] as? String ?? ""
            
                // ...
        //    }) { (error) in
        //        print(error.localizedDescription)
        //}
        
        return cell
    }
    
}
