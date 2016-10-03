//
//  GeneralCourseViewController.swift
//  StudentLink
//
//  Created by Danny Tan on 9/25/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit

enum CourseViewType {
    case Professor
    case Date
}

class GeneralCourseViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var professorDataSource = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var dateDataSource = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var viewType: CourseViewType!
    var courseName: String!
    var professorName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch viewType! {
        case .Professor:
            self.navigationItem.title = courseName.uppercaseString
        case .Date:
            return
        }
        
    }
    
    class func create(type: CourseViewType, courseName: String) -> GeneralCourseViewController {
        let storyboard = UIStoryboard(name: "GeneralCourseView", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("GeneralCourseViewController") as! GeneralCourseViewController
        
        controller.viewType = type
        controller.courseName = courseName
        
        let _ = controller.view
        
        return controller
    }
}

extension GeneralCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewType = viewType {
            switch viewType {
            case .Professor:
                return professorDataSource.count
            case .Date:
                return dateDataSource.count
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch viewType! {
        case .Professor:
            let professor = professorDataSource[indexPath.row]
            
            guard let cell = tableView.dequeueReusableCellWithIdentifier("generalCell") as? GeneralCell else {
                fatalError()
            }
            
            cell.labelName.text = professor
            
            return cell
            
        case .Date:
            let date = dateDataSource[indexPath.row]
            
            guard let cell = tableView.dequeueReusableCellWithIdentifier("generalCell") as? GeneralCell else {
                fatalError()
            }
            
            cell.labelName.text = date
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch viewType! {
        case .Professor:
            let professor = professorDataSource[indexPath.row]
            
            let generalCourseViewController = GeneralCourseViewController.create(.Date, courseName: courseName)
            DataService.retrieveDate(courseName, professorName: professor, completion: { (dates) in
                if let dates = dates {
                    generalCourseViewController.dateDataSource = dates
                    generalCourseViewController.professorName = professor
                    generalCourseViewController.navigationItem.title = professor.uppercaseString
                }
                self.navigationController?.pushViewController(generalCourseViewController, animated: true)
            })
        case .Date:
            let date = dateDataSource[indexPath.row]
        
            if let professorName = self.professorName {
                _ = [UIImage]()
                DataService.retrieveData(courseName, professorName: professorName, date: date, completion: { (images) in
                    let notesCollectionViewController = NotesCollectionViewController.create()
                    notesCollectionViewController.imageNames = images!
                    self.navigationController?.pushViewController(notesCollectionViewController, animated: true)
                })
            }
        }
    }
}