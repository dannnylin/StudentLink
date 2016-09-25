//
//  LoginViewController.swift
//  StudentLink
//
//  Created by Danny Tan on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(sender: UIButton) {
        let signInViewController = SignInViewController.create(.Login)
        let signInNavigationController = UINavigationController(rootViewController: signInViewController)
        self.presentViewController(signInNavigationController, animated: true, completion: nil)
    }
    
    @IBAction func signupPressed(sender: UIButton) {
        let signInViewController = SignInViewController.create(.Signup)
        let signInNavigationController = UINavigationController(rootViewController: signInViewController)
        self.presentViewController(signInNavigationController, animated: true, completion: nil)
    }

    class func create() -> LoginViewController {
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController

        return controller
    }
    @IBOutlet weak var otherLoginButton: UIButton!
    @IBOutlet weak var LogoView: UIView!
}

