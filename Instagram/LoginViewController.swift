//
//  LoginViewController.swift
//  Instagram
//
//  Created by Noureddine Youssfi on 3/1/16.
//  Copyright © 2016 Noureddine Youssfi. All rights reserved.
//

import UIKit
import Parse
import PasswordTextField


class LoginViewController: UIViewController,UIViewControllerTransitioningDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: PasswordTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIView.animateWithDuration(4, delay: 1, options:[UIViewAnimationOptions.AllowUserInteraction,UIViewAnimationOptions.Repeat,UIViewAnimationOptions.Autoreverse], animations: {
            self.view.backgroundColor = self.randomColors()
            self.view.backgroundColor = self.randomColors()
            
            
            
            }, completion:nil )
        if passwordField.isInvalid(){
            print(passwordField.errorMessage)
        }
    }
    
    func randomColors() -> UIColor {
        let blue : CGFloat = CGFloat(arc4random() % 375) / 276
        let green : CGFloat = CGFloat(arc4random() % 398) / 276 + 0.5
        let red : CGFloat = CGFloat(arc4random() % 199) / 276 + 0.5
        
        return UIColor(hue: blue, saturation: green, brightness: red, alpha: 1)
    }
    
    override func viewDidAppear(animated: Bool) {
        randomColors()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onSignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?,error: NSError?) -> Void in
            if user != nil{
                print("you're logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
    }

    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackgroundWithBlock { (success: Bool,error: NSError?) -> Void in
            if success {
                print("created user")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }else {
                print(error?.localizedDescription)
                if error?.code == 202 {
                     print("username is taken")
                }
            }
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
