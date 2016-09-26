//
//  DataService.swift
//  StudentLink
//
//  Created by Danny on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit
import Firebase


let FIREBASE_BASE_URL = "https://studentlink-11d60.firebaseio.com/"

class DataService {
    static let sharedInstance = DataService()
    
    private var _USERS_REF = FIRDatabase.database().referenceFromURL("\(FIREBASE_BASE_URL)/users")
    
    private var _CLASSES_REF = FIRDatabase.database().referenceFromURL("\(FIREBASE_BASE_URL)/classes")
    
    var USERS_REF: FIRDatabaseReference {
        return _USERS_REF
    }
    
    var CLASSES_REF: FIRDatabaseReference {
        return _CLASSES_REF
    }
    
    func createFirebaseUser(uid: String, provider: String) {
        let userProvider = ["Provider": provider]
        USERS_REF.child(uid).setValue(userProvider)
    }
    
    func addClassToUser(className: String) {
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            USERS_REF.child(uid).child("classes").updateChildValues(["\(className)": true])
        }
    }
    
    func addClassToClasses(className: String) {
        CLASSES_REF.child(className).setValue(true)
    }
    
    func removeClassToUser(className:String){
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            USERS_REF.child(uid).child("classes").updateChildValues(["\(className)": false])
        }
    }
    
    func addNotesToClass(className: String, professorName: String, noteDate:String, noteName: String) {
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            CLASSES_REF.child(className).child(professorName).child(noteDate).child(noteName).setValue(["Uploader": uid])
        }
    }
    
    class func retrieveClasses(completion: [Class]? -> Void) {
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            DataService.sharedInstance.USERS_REF.child(uid).child("classes").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                var classes = [Class]()
                if let classDict = snapshot.value as? [String: Bool] {
                    for aClass in classDict {
                        if aClass.1 {
                            let newClass = Class(name: aClass.0)
                            classes.append(newClass)
                        }
                    }
                    completion(classes)
                } else {
                    completion(nil)
                }
            })
        }
    }
    
    class func retrieveProfessor(className: String, completion: [String]? -> Void) {
        DataService.sharedInstance.CLASSES_REF.child(className).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if let classDict = snapshot.value as? NSDictionary, professorDict = classDict as? NSDictionary {
                var professorNames = [String]()
                for aProfessor in professorDict {
                    
                    if let professorName = aProfessor.key as? String {
                        professorNames.append(professorName)
                    }
                }
                completion(professorNames)
            } else {
                completion(nil)
            }
        })
    }
    class func retrieveDate(className: String, professorName:String, completion: [String]? -> Void) {
        DataService.sharedInstance.CLASSES_REF.child(className).child(professorName).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if let classDict = snapshot.value as? NSDictionary, professorDict = classDict as? NSDictionary, dateDict = professorDict as? NSDictionary {
                var dates = [String]()
                for aDate in dateDict{
                    
                    if let date = aDate.key as? String {
                        dates.append(date)
                    }
                }
                completion(dates)
            } else {
                completion(nil)
            }
        })
    }
    class func retrieveData(className: String, professorName:String, date:String, completion: [String]? -> Void) {
        DataService.sharedInstance.CLASSES_REF.child(className).child(professorName).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if let classDict = snapshot.value as? NSDictionary{
                if let picDicts = classDict.allValues as? [NSDictionary] {
                    for aPicDict in picDicts {
                        if let imageNames =  aPicDict.allKeys as? [String]{
                             completion(imageNames)
                        }
                    }
                }
            }
            else {
                completion(nil)
            }
        })
    }
    
}