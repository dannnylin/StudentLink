//
//  UploadViewController.swift
//  StudentLink
//
//  Created by Danny Tan on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {
    
    @IBOutlet weak var notesImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imageArray = [UIImage]()
    var imageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = 0
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipingRight))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipingLeft))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func swipingRight() {
        print("User swiped right")
        if imageArray.count != 0 {
            imageIndex -= 1
            if imageIndex < 0 {
                imageIndex += 1
                return
            }
            notesImageView.image = imageArray[imageIndex]
            self.pageControl.currentPage = imageIndex
        }
    }
    
    func swipingLeft(){
        print("User swiped left")
        if imageArray.count != 0 {
            imageIndex += 1
            if imageIndex >= imageArray.count {
                imageIndex -= 1
                return
            }
            notesImageView.image = imageArray[imageIndex]
            self.pageControl.currentPage = imageIndex
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if imageArray.count != 0 {
            notesImageView.image = imageArray[imageIndex]
            pageControl.numberOfPages = imageArray.count
            pageControl.currentPage = imageArray.count
        }
    }
    
    
    
    
    
    @IBAction func changeProfilePictureButton(sender: AnyObject) {
        
        let changePictureActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        let takePictureAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { (action) in
            
            imagePicker.sourceType = .Camera
            
            self.presentViewController(imagePicker,animated: true, completion:nil)
            
        }
        
        let photoLibraryAlertAction = UIAlertAction(title: "Photo Library", style: .Default) { (action) in
            
            
            
            imagePicker.sourceType = .PhotoLibrary
            
            self.presentViewController(imagePicker,animated: true, completion:nil)
            
        }
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
            return
            
        }
        
        changePictureActionSheet.addAction(takePictureAlertAction)
        
        changePictureActionSheet.addAction(photoLibraryAlertAction)
        
        changePictureActionSheet.addAction(cancelAlertAction)
        
        self.presentViewController(changePictureActionSheet, animated: true, completion: nil)
        
    }
    
    class func create() -> UploadViewController {
        let storyboard = UIStoryboard(name: "Upload", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("UploadViewController") as! UploadViewController
        return controller
    }
    
}



extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let imageTaken = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imageArray.append(imageTaken!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

