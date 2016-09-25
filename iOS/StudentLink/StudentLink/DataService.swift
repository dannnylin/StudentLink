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
}