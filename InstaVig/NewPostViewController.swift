//
//  NewPostViewController.swift
//  InstaVig
//
//  Created by Alex Vig on 13/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import UIKit
import Firebase

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var ref: DatabaseReference!
    
    @IBOutlet weak var textOutlet: UITextView!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        ref = Database.database().reference()
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        imageViewOutlet.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func post(_ sender: Any) {
        if (image == nil && textOutlet.text == "") {
            Utilities.showAlert("You cannot share an empty post.", self)
            return
        }
        
        let postId = UUID().uuidString
        
        if (image != nil && textOutlet.text != "") {
            //self.ref.child("posts").childByAutoId().setValue(post.toJson())
            uploadImage(postId)
            
            //uploadWholePost(postId, imageUrl)
        } else if (image != nil) {
            
        } else {
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    private func uploadImage(_ postId: String) -> String {
        let imagesRef = Storage.storage().reference().child("images/" + postId + ".jpg")
        let data = image!.jpegData(compressionQuality: 0.8)
        let metadata = StorageMetadata()
        
        metadata.contentType = "image/jpeg"
        
        _ = imagesRef.putData(data!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                Utilities.showAlert("Image upload failed for some reason..", self)
                
                return
            }
            
            _ = metadata.size
            
            imagesRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    Utilities.showAlert("Image upload failed for some reason..", self)
                    return
                }
                
                self.uploadWholePost(postId, downloadURL.absoluteString)
            }
        }
        
        return imagesRef.fullPath;
    }
    
    private func uploadWholePost(_ postId: String, _ url: String) {
        let userId = Auth.auth().currentUser!.uid
        let post = Post(_id: postId, _text: textOutlet.text, _userId: userId, _imageUrl: url)
        
        self.ref.child("posts").childByAutoId().setValue(post.toJson())
    }
    
}
