//
//  CaptionController.swift
//  Instagram
//
//  Created by Noureddine Youssfi on 3/6/16.
//  Copyright © 2016 Noureddine Youssfi. All rights reserved.
//

import UIKit

class CaptionController: UIViewController {
    var captionImageHolder: UIImage?
    var caption: String?
    @IBOutlet weak var captionImage: UIImageView!
    @IBOutlet weak var captionTxtView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        captionImage.image = Post.resize(captionImageHolder!, newSize: CGSize(width: 75, height: 75))
        captionTxtView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        captionTxtView.text = ""
    }
    @IBAction func backButtonClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onShare(sender: AnyObject) {
        let image = Post.resize(captionImageHolder!, newSize: CGSize(width: 375, height: 375))
        
        caption = captionTxtView.text! ?? ""
        
        Post.postUserImage(image, withCaption: caption) { (success: Bool, error: NSError?) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
