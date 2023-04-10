//
//  PersonalPostCell.swift
//  ReadHub
//
//  Created by Chinmay Bansal on 4/8/23.
//

import UIKit

class FollowingPostCell: UITableViewCell {
    
    
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with post: Post) {
        // TODO: Pt 1 - Configure Post Cell
        
        // Username
        if let user = post.user {
        
            let username = user.username
            let pagesText = post.pages
            let titleText = post.title
            let labelText = (username)! + " has read " + (pagesText)! + " pages of \"" + (titleText)! + "\"."
            postLabel.text = labelText
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat  = "MM/dd/yyyy"
            
            let dateString = dateFormatter.string(from: post.createdAt!)
            dateLabel.text = dateString
            
        }

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
