//
//  FacebookInfo.swift
//  StudentLink
//
//  Created by Danny Tan on 10/3/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class FacebookInfo {
    
    static let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, email, picture.type(large)"])
    
    class func getInfo() {
        graphRequest.startWithCompletionHandler{(connection, result, error) -> Void in
            
            if error != nil {
                print (error)
                return
            }
            
            if let name = result ["name"] as? String {
                DataService.sharedInstance.addUserInformation("name", info: name)
            }
            
            if let email = result ["email"] as? String {
                DataService.sharedInstance.addUserInformation("email", info: email)
            }
            
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                DataService.sharedInstance.addUserInformation("picture", info: url)
            }
        }
    }
}

