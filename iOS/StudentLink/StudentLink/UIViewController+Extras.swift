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
        self.view.window?.rootViewController = MainTabBarController.create()
    }
}