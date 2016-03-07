//
//  PostsCell.swift
//  Instagram
//
//  Created by Noureddine Youssfi on 3/6/16.
//  Copyright © 2016 Noureddine Youssfi. All rights reserved.
//

import UIKit
import Parse
import DOFavoriteButton

class PostsCell: UITableViewCell {

    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var favButton: DOFavoriteButton!
    
    var Like_Button = DOFavoriteButton(frame: CGRectMake(-18, -18, 72, 72), image: UIImage(named: "Like-33"))
    var view: UIView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var infoObject: PFObject? {
        didSet{
            info = postInfo(pointObject: infoObject!)
            info.cell = self
            Like_Button.addTarget(self, action: Selector("tapped:"), forControlEvents: .TouchUpInside)
            Like_Button.imageColorOn = UIColor(red: 0.9098, green: 0.2314, blue: 0.2078, alpha: 1.0)
            Like_Button.circleColor = UIColor(red: 0.4431, green: 0.1647, blue: 0.4588, alpha: 1.0)
            Like_Button.duration = 2.0
            Like_Button.lineColor = UIColor(red: 0.3333, green: 0.6745, blue: 0.9333, alpha: 1.0) 
            self.favButton!.addSubview(Like_Button)
        }
    }
    func tapped(sender: DOFavoriteButton) {
        if sender.selected {
            // deselect
            sender.deselect()
            
            
        }else {
            
            // select with animation
            sender.select()
            
        }
        
    }
    var info: postInfo! {
        didSet{
            postImage.image = info.photo

            timeStampLabel.text = "\(infoObject!.createdAt!)"
            usernameLabel.text = info.name
            captionLabel.text = info.caption
        }
    }

}
