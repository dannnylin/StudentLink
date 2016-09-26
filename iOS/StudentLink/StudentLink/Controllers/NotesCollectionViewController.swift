//
//  NotesCollectionViewController.swift
//  StudentLink
//
//  Created by Danny Tan on 9/25/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit


class NotesCollectionViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageNames = [String]() {
        didSet{
            for image in imageNames {
                DataStorage.sharedInstance.extractImages(image, completion: { (image) in
                    self.imageArray.append(image!)
                })
            }
        }
    }
    
    var imageArray = [UIImage](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    class func create() -> NotesCollectionViewController{
        let storyboard = UIStoryboard(name: "Notes", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("NotesCollectionViewController") as! NotesCollectionViewController
        return controller

    }

}

extension NotesCollectionViewController:UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("noteCell", forIndexPath: indexPath) as? NoteCollectionViewCell
            else {
                fatalError()
        }
        cell.noteImageView.image = imageArray[indexPath.row]
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let image = imageArray[indexPath.row]
        
        let noteDetailViewController = NoteDetailViewController.create()
        noteDetailViewController.setupImage(image)
        
        self.presentViewController(noteDetailViewController, animated: true, completion: nil)
        
    }
    
}