//
//  MainTabBarController.swift
//  StudentLink
//
//  Created by Danny on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var homeViewController: UIViewController!
    var uploadViewController: UIViewController!
    var profileViewController: UIViewController!
    
    var navigationControllers = [UINavigationController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViewControllers()
        
        setupNavigationControllers()
        
        
        self.viewControllers = navigationControllers
        self.tabBar.tintColor = UIColor.nicePurple()
    }
    
    func createViewControllers() {
        homeViewController = HomeViewController.create()
        homeViewController.view.backgroundColor = UIColor.whiteColor()
        homeViewController.navigationItem.title = "CLASSES"
        
        uploadViewController = UploadViewController.create()
        uploadViewController.view.backgroundColor = UIColor.whiteColor()
        uploadViewController.navigationItem.title = "UPLOAD"
        
        profileViewController = ProfileViewController.create()
        profileViewController.view.backgroundColor = UIColor.whiteColor()
        profileViewController.navigationItem.title = "PROFILE"
    }
    
    func setupNavigationControllers() {
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let uploadNavigationController = UINavigationController(rootViewController: uploadViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        homeNavigationController.tabBarItem.title = "HOME"
        homeNavigationController.tabBarItem.image = UIImage(named: "classes")
        
        uploadNavigationController.tabBarItem.title = "UPLOAD"
        uploadNavigationController.tabBarItem.image = UIImage(named: "upload")
        
        profileNavigationController.tabBarItem.title = "PROFILE"
        profileNavigationController.tabBarItem.image = UIImage(named: "profile")
        
        navigationControllers = [homeNavigationController, uploadNavigationController, profileNavigationController]
    }
    
    class func create() -> MainTabBarController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("MainTabBarController") as! MainTabBarController
        
        let _ = controller.view
        
        return controller
    }
}
