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
    
    
    var dataSource = [Class]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Create Schedule"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(add))
        
    }
    
    func add() {
        print("pressed add")
        addClassToFirebase()
    }
    
    func addClassToFirebase() {
        let lastRowIndex = tableView.numberOfRowsInSection(0)
        let pathToLastRow = NSIndexPath(forRow: lastRowIndex, inSection: 0)
        
        if let cell = tableView.cellForRowAtIndexPath(pathToLastRow) as? ScheduleCell {
            if let className = cell.classTextField.text {
                cell.classTextField.text != ""
              //  var classToAdd =
            }
        }
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
        return dataSource.count + 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell")! as! ScheduleCell
        return cell
    }
}

extension scheduleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        add()
        return false
    }

}
