//
//  scheduleViewController.swift
//  StudentLink
//
//  Created by Danny Tan on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit

class scheduleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Create Schedule"
        
    }

    class func create() -> scheduleViewController {
        let storyboard = UIStoryboard(name: "ScheduleStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("ScheduleViewController") as! scheduleViewController
        return controller
    }
}

extension scheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
