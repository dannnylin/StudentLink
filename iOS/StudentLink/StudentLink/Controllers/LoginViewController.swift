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
        loginButtonClicked()
    }
    
    func loginButtonClicked() {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else if result.isCancelled {
                print("Facebook login cancelled")
            } else {
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    
                    let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                    FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                        // Login successful
                        if let error = error {
                            print(error)
                        }
                        
                        // move to home
                        self.view.window?.rootViewController = MainTabBarController.create()
                    }
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print(result["email"])
                }
            })
        }
    }

    class func create() -> LoginViewController {
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController

        return controller
    }
    @IBOutlet weak var otherLoginButton: UIButton!
    @IBOutlet weak var LogoView: UIView!
}

