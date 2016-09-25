//
//  ScheduleCell.swift
//  StudentLink
//
//  Created by Danny Tan on 9/24/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        classTextField.becomeFirstResponder()
    }

    @IBOutlet weak var classTextField: UITextField!

}
