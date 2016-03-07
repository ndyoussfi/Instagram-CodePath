//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Noureddine Youssfi on 3/5/16.
//  Copyright © 2016 Noureddine Youssfi. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    let userDidLogoutNotification = "userDidLogoutNotification"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOut(sender: AnyObject) {
        print("Logging out user: \(PFUser.currentUser()!.username!)")
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        dismissViewControllerAnimated(true, completion: nil);
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
