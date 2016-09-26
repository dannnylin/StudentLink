//
//  NoteDetailViewController.swift
//  StudentLink
//
//  Created by Danny on 9/26/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var noteImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func create() -> NoteDetailViewController {
        let storyboard = UIStoryboard(name: "NoteDetailView", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("NoteDetailViewController") as! NoteDetailViewController
        
        let _ = controller.view
        
        return controller
    }
    
    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(noteImageView.image!, self, #selector(image(_:didFinishSavingWithError: contextInfo:)), nil)
    }
    
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeMutablePointer<Void>) {
        if error != nil {
            print("Image Can not be saved")
        }
        else {
            print("Successfully saved Image")
        }
    }
    
    func setupImage(noteImage: UIImage) {
        self.noteImageView.image = noteImage
    }
}