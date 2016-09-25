//
//  UIViewController+Extras.swift
//  StudentLink
//
//  Created by Danny on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit

extension UIViewController {
    func moveToMainScreen() {
        UIView.animateWithDuration(0.4, delay: 0, options: .TransitionFlipFromLeft, animations: {
            self.view.window?.rootViewController = MainTabBarController.create()
            }, completion: nil)
    }
    
    func moveToLoginScreen() {
        UIView.animateWithDuration(0.4, delay: 0, options: .TransitionFlipFromLeft, animations: {
            self.view.window?.rootViewController = LoginViewController.create()
            }, completion: nil)
    }
}