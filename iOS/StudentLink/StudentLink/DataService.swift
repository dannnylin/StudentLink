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
    
    var USERS_REF: FIRDatabaseReference {
        return _USERS_REF
    }
    
    func createFirebaseUser(uid: String, provider: String) {
        let userProvider = ["Provider": provider]
        USERS_REF.child(uid).setValue(userProvider)
    }
    
    func addClassToUser(className:String){
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            USERS_REF.child(uid).child("classes").updateChildValues(["\(className)": true])
        }
    }
    
    func removeClassToUser(className:String){
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            USERS_REF.child(uid).child("classes").updateChildValues(["\(className)": false])
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
    
    
}