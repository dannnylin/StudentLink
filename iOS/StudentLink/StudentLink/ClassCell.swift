//
//  ClassCell.swift
//  StudentLink
//
//  Created by Danny on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit

class ClassCell: UITableViewCell {
    static let identifier = "ClassCell"
    
    var theClass: Class!
    
    @IBOutlet weak var classNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureForClass(theClass: Class) {
        classNameLabel.text = theClass.name
    }
}