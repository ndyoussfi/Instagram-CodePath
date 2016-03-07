//
//  MediaViewController.swift
//  Instagram
//
//  Created by Noureddine Youssfi on 3/5/16.
//  Copyright © 2016 Noureddine Youssfi. All rights reserved.
//

import UIKit
import ALCameraViewController

class MediaViewController: UIViewController {
    
    var croppingEnabled: Bool = false
    var libraryEnabled: Bool = true
    var savedImg: UIImage?
    
    @IBOutlet weak var placeHolder: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView()
        self.placeHolder.hidden = false
        self.posterView.hidden = true
        savedImg = nil
        
    }
    
    override func viewDidAppear(animated: Bool) {

        self.placeHolder.hidden = true
        self.posterView.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonClicked(sender: AnyObject) {
        cameraView()
    }
    
    @IBAction func openLibrary(sender: AnyObject) {
        let libraryViewController = ALCameraViewController.imagePickerViewController(croppingEnabled) { (image) -> Void in
            if image != nil{
                let newImage = Post.resize(image!, newSize: CGSize(width: 375, height: 375))
                self.posterView.image = newImage
                self.savedImg = newImage
            } else if self.savedImg != nil{
                self.posterView.image = self.savedImg
                self.placeHolder.hidden = true
                self.posterView.hidden = false
            } else {
                self.posterView.image = image
                self.posterView.hidden = false
                self.placeHolder.hidden = false
            }
            self.posterView.hidden = false
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        presentViewController(libraryViewController, animated: true, completion: nil)
    }

    @IBAction func openCamera(sender: AnyObject) {
        cameraView()

    }
    func cameraView(){
        croppingEnabled = true
    let cameraViewController = ALCameraViewController(croppingEnabled: croppingEnabled, allowsLibraryAccess: libraryEnabled) { (image) -> Void in
        if image != nil{
            let newImage = Post.resize(image!, newSize: CGSize(width: 375, height: 375))
            self.posterView.image = newImage
            self.savedImg = newImage
        } else if self.savedImg != nil{
            self.posterView.image = self.savedImg
            self.placeHolder.hidden = true
            self.posterView.hidden = false
        } else {
            self.posterView.image = image
            self.posterView.hidden = false
            
        }
        self.posterView.hidden = false
    self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    presentViewController(cameraViewController, animated: true, completion: nil)
    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "captionSegue" {
            let nav = segue.destinationViewController as! UINavigationController
            let captionViewController = nav.topViewController as! CaptionController
            let capImg = savedImg!
            captionViewController.captionImageHolder = capImg
        }
    }
    

}
