//
//  SignInViewController.swift
//  StudentLink
//
//  Created by Danny on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

enum AuthMode {
    case Login
    case Signup
}

class SignInViewController: UIViewController {
    
    var mode: AuthMode!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupStyling()
    }
    
    func setupStyling() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(dismiss))
        
        if let mode = mode {
            switch mode {
            case .Login:
                actionButton.setTitle("Log In", forState: .Normal)
                facebookButton.setTitle("Log In With Facebook", forState: .Normal)
                self.navigationItem.title = "Log In"
            case .Signup:
                actionButton.setTitle("Sign Up", forState: .Normal)
                facebookButton.setTitle("Sign Up With Facebook", forState: .Normal)
                self.navigationItem.title = "Sign Up"
            }
        }
    }
    
    func checkFieldsAndPerformAction() {
        if let email = emailTextField.text, password = passwordTextField.text, mode = mode {
            switch mode {
            case .Login:
                FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    if let uid = user?.uid {
                        StudentLinkUserDefaults.setUID(uid)
                    }
                })
            case .Signup:
                FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    if let uid = user?.uid {
                        StudentLinkUserDefaults.setUID(uid)
                        DataService.sharedInstance.createFirebaseUser(uid, provider: "Email")
                    }
                    
                })
            }
            self.moveToMainScreen()
        }
    }
    
    @IBAction func actionButtonPressed(sender: UIButton) {
        if let mode = mode {
            switch mode {
            case .Login:
                checkFieldsAndPerformAction()
                return
            case .Signup:
                checkFieldsAndPerformAction()
            }
        }
    }
    
    @IBAction func facebookButtonPressed(sender: UIButton) {
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
                        
                        if let uid = user?.uid, mode = self.mode {
                            switch mode {
                            case .Signup:
                                DataService.sharedInstance.createFirebaseUser(uid, provider: "Facebook")
                                let scheduleNavigationController = UINavigationController(rootViewController: scheduleViewController.create())
                                self.presentViewController(scheduleNavigationController, animated: true, completion: nil)
                            case .Login:
                                self.moveToMainScreen()
                            }
                            StudentLinkUserDefaults.setUID(uid)
                        }
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
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    class func create(mode: AuthMode) -> SignInViewController {
        let storyboard = UIStoryboard(name: "SignInView", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
        controller.mode = mode
        return controller
    }
}