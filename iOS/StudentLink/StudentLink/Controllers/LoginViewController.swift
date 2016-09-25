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
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyling()
    }
    
    func setupStyling() {
        loginButton.layer.cornerRadius = 5.0
        signupButton.layer.cornerRadius = 5.0
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
}

