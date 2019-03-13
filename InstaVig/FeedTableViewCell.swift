//
//  FeedTableViewCell.swift
//  InstaVig
//
//  Created by Alex Vig on 13/03/2019.
//  Copyright © 2019 Alex Vig. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameOutlet: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var bodyOutlet: UITextView!
    @IBOutlet weak var imageOutlet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
