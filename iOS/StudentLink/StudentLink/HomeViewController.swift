//
//  HomeViewController.swift
//  StudentLink
//
//  Created by Danny on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var dataSource = [Class]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.retrieveClasses { (classes) in
            if let classes = classes {
                self.dataSource = classes
            }
        }
        
        tableView.allowsSelection = false
    }
    
    class func create() -> HomeViewController {
        let storyboard = UIStoryboard(name: "HomeView", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        return controller
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let theClass = dataSource[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(ClassCell.identifier) as? ClassCell else {
            fatalError("Must have identifier with \(ClassCell.identifier)")
        }
        
        cell.configureForClass(theClass)
        
        return cell
    }
}