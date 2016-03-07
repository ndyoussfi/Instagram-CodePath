//
//  postInfo.swift
//  Instagram
//
//  Created by Noureddine Youssfi on 3/6/16.
//  Copyright © 2016 Noureddine Youssfi. All rights reserved.
//

import UIKit
import Parse

class postInfo: NSObject {
    
    var photo: UIImage?
    var person: PFUser?
    var caption: String?
    var favCount: Int?
    var commentCount: Int?
    var name: String?
    var cell: PostsCell?
    
    init(pointObject: PFObject) {
        super.init()
        cell = PostsCell()
        
        caption = pointObject["caption"] as? String
        
        favCount = pointObject["likesCount"] as? Int
        commentCount = pointObject["commentsCount"] as? Int
        person = pointObject["author"] as! PFUser?
        name = pointObject["name"] as? String
        
        if let userPicture = pointObject.valueForKey("media")! as? PFFile {
            userPicture.getDataInBackgroundWithBlock({
                (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    let image = UIImage(data:imageData!)
                    self.cell!.postImage.image = image
                    self.photo = image
                    
                    
                }
            })
        }
    }
    
    
}
