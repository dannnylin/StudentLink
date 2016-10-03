//
//  ProfileViewController.swift
//  StudentLink
//
//  Created by Danny on 9/25/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logoutButtonPressed(sender: UIButton) {
        try! FIRAuth.auth()?.signOut()
        
        self.moveToLoginScreen()
    }
    
    class func create() -> ProfileViewController {
        let storyboard = UIStoryboard(name: "ProfileView", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        return controller
    }
}