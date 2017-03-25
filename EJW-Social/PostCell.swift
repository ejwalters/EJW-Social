//
//  PostCell.swift
//  EJW-Social
//
//  Created by Eric Walters on 3/1/17.
//  Copyright © 2017 Eric Walters. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    var post: Post!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post) {
        self.post = post
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
    }


}
