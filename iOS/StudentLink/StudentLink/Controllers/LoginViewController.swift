//
//  LoginViewController.swift
//  StudentLink
//
//  Created by Danny Tan on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
   
    }

    class func create() -> LoginViewController {
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController

        return controller
    }
    @IBOutlet weak var otherLoginButton: UIButton!
    @IBOutlet weak var LogoView: UIView!
}

