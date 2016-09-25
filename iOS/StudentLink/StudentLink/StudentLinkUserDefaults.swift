//
//  StudentLinkUserDefaults.swift
//  StudentLink
//
//  Created by Danny on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit

class StudentLinkUserDefaults {
    static let UIDKey = "studentLink-UID"
    class func setUID(UID: String) {
        NSUserDefaults.standardUserDefaults().setObject(UID, forKey: UIDKey)
    }
    
    class func getUID() -> String? {
        if let UID = NSUserDefaults.standardUserDefaults().objectForKey(UIDKey) as? String {
            return UID
        }
        return nil
    }
}
