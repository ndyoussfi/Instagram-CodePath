//
//  Post.swift
//  Instagram
//
//  Created by Noureddine Youssfi on 3/6/16.
//  Copyright © 2016 Noureddine Youssfi. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
         class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        let post = PFObject(className: "Post")
        
        
        post["media"] = getPFFileFromImage(image)
        post["author"] = PFUser.currentUser()
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        post["name"] = PFUser.currentUser()?.username!
        
       
        post.saveInBackgroundWithBlock(completion)
    }
    
    class func postUserProfile(image: UIImage?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Profile")
        
        post["name"] = PFUser.currentUser()?.username!
        resize(image!, newSize: CGSize(width: 100, height: 100))
        post["profilePicture"] = getPFFileFromImage(image)
        
        post.saveInBackgroundWithBlock(completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    class func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    
}
