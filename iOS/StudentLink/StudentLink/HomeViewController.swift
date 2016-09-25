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
    @IBOutlet weak var addClassesViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var cancelBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activityIndicator = UIActivityIndicatorView()
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .Gray
        
        activityIndicator.startAnimating()
        
        DataService.retrieveClasses { (classes) in
            if let classes = classes {
                self.dataSource = classes
            }
            activityIndicator.stopAnimating()
        }
        
        tableView.allowsSelection = false
        tableView.allowsMultipleSelectionDuringEditing = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .Plain, target: self, action: #selector(addClass))
        
        cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelAdd))
        
        self.navigationItem.leftBarButtonItem = nil
        
        addButton.hidden = true
        
        classTextField.delegate = self
    }
    
    func cancelAdd() {
        UIView.animateWithDuration(0.4) { 
            self.addClassesViewHeightConstraint.constant = 0
            self.addButton.hidden = true
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    func addClass() {
        UIView.animateWithDuration(0.4) { 
            self.addClassesViewHeightConstraint.constant = 44
            self.addButton.hidden = false
            self.navigationItem.leftBarButtonItem = self.cancelBarButtonItem
        }
    }
    
    @IBAction func addClassPressed(sender: AnyObject) {
        if let className = classTextField.text where className != "" {
            for aClass in dataSource {
                if aClass.name == className {
                    let alert = UIAlertController(title: "Error", message: "You already have this course added.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alert.addAction(OKAction)
                    self.presentViewController(alert, animated: true, completion: { 
                        return
                    })
                    return
                }
            }
            DataService.sharedInstance.addClassToUser(className)
            DataService.sharedInstance.addClassToClasses(className)
            let tempClass = Class(name: className)
            dataSource.append(tempClass)
            classTextField.text = ""
            classTextField.resignFirstResponder()
            
            UIView.animateWithDuration(0.4) {
                self.addClassesViewHeightConstraint.constant = 0
                self.addButton.hidden = true
                self.navigationItem.leftBarButtonItem = nil
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a course name.", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(OKAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
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
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dataSource.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addClassPressed(textField)
        
        return false
    }
}