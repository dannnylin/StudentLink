//
//  DataStorage.swift
//  StudentLink
//
//  Created by Danny Tan on 9/25/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

let FIREBASE_STORAGE_BASEURL = "gs://studentlink-11d60.appspot.com"

class DataStorage {
    static let sharedInstance = DataStorage()
    
    private var _USERS_REF = FIRStorage.storage().referenceForURL("\(FIREBASE_STORAGE_BASEURL)/users")
    
    var USERS_REF: FIRStorageReference {
        return _USERS_REF
    }
    
    func addPictureToClass(className: String, image: UIImage, imageName: String){
        let profilePicRef = USERS_REF.child(className).child("\(imageName).jpg")
        USERS_REF.child(className)
        if let uploadData = UIImageJPEGRepresentation(image, 0){
            profilePicRef.putData(uploadData, metadata: nil, completion: { (meta, error) in
                if error != nil {
                    print (error)
                }
                else{
                    print("imageAdded")
                }
            })
        }
    }
}



