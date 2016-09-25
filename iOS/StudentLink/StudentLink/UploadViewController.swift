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
    @IBOutlet weak var addPictureImageButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addPictureBottomButton: UIButton!
    
    var doneBarButtonItem: UIBarButtonItem!
    
    
    var imageArray = [UIImage]() {
        didSet {
            if imageArray.count > 0 {
                addPictureImageButton.hidden = true
                addPictureBottomButton.hidden = false
                deleteButton.enabled = true
                doneBarButtonItem.enabled = true
            } else {
                addPictureImageButton.hidden = false
                addPictureBottomButton.hidden = true
                deleteButton.enabled = false
                doneBarButtonItem.enabled = false
            }
        }
    }
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
        
        addPictureImageButton.setTitleColor(UIColor.nicePurple(), forState: .Normal)
        
        addPictureBottomButton.hidden = true
        deleteButton.enabled = false
        
        doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(done))
        
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
        
        doneBarButtonItem.enabled = false
        deleteButton.setTitleColor(UIColor.whiteColor().colorWithAlphaComponent(0.3), forState: .Disabled)
        
        
    }
    
    func done() {
        // upload photos to firebase
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
            pageControl.currentPage = imageIndex
        }
    }
    
    
    func addPicture() {
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
    
    
    @IBAction func changeProfilePictureButton(sender: AnyObject) {
        addPicture()
    }
    
    @IBAction func addImagePressed(sender: UIButton) {
        addPicture()
    }
    
    @IBAction func deletePictureAction(sender: UIButton) {
        if imageArray.count > 1 {
            if imageIndex != 0 {
                notesImageView.image = imageArray[imageIndex-1]
            } else {
                notesImageView.image = imageArray[imageIndex+1]
            }
            imageArray.removeAtIndex(imageIndex)
            imageIndex -= 1
            pageControl.currentPage -= 1
            pageControl.numberOfPages -= 1
        } else {
            notesImageView.image = nil
            imageArray.removeAll()
            pageControl.currentPage = 0
            pageControl.numberOfPages = 0
            imageIndex = 0
        }
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

