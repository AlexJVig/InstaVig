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
        
        cell.bodyOutlet?.text = post.text
        cell.fullNameOutlet?.text = post.text
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
