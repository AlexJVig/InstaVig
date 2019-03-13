//
//  NewPostViewController.swift
//  InstaVig
//
//  Created by Alex Vig on 13/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textOutlet: UITextView!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        dismiss(animated: true, completion: nil)
    }
    
}
