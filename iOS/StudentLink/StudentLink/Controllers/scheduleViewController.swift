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
    var doneBarButtonItem: UIBarButtonItem!
    
    
    var dataSource = [Class]() {
        didSet {
            tableView.reloadData()
            if dataSource.isEmpty {
                doneBarButtonItem.enabled = false
            }
            else {
                doneBarButtonItem.enabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Create Schedule"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(add))
        doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(done))
        doneBarButtonItem.enabled = false
        
        self.navigationItem.leftBarButtonItem = doneBarButtonItem
        
    }
    
    func add() {
        print("pressed add")
        addClassToFirebase()
    }
    
    func done() {
        let lastRowIndex = tableView.numberOfRowsInSection(0)-1
        let pathToLastRow = NSIndexPath(forRow: lastRowIndex, inSection: 0)
        
        if let cell = tableView.cellForRowAtIndexPath(pathToLastRow) as? ScheduleCell {
            cell.classTextField.resignFirstResponder()
        }
        
        moveToMainScreen()
    }
    
    func addClassToFirebase() {
        let lastRowIndex = tableView.numberOfRowsInSection(0)-1
        let pathToLastRow = NSIndexPath(forRow: lastRowIndex, inSection: 0)
        
        if let cell = tableView.cellForRowAtIndexPath(pathToLastRow) as? ScheduleCell {
            if let className = cell.classTextField.text {
                var classToAdd = Class()
                classToAdd.name = className
                dataSource.append(classToAdd)
                DataService.sharedInstance.addClassToUser(className)
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
