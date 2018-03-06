//
//  NewCheckoutViewController.swift
//  Inventarium
//
//  Created by SUN, KEVIN on 2/21/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import UIKit
import os.log

class NewCheckoutViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var periodField: UITextField!
    @IBOutlet weak var typeField: UIPickerView!
    @IBOutlet weak var quantityField: UILabel!
    @IBOutlet weak var dateField: UIDatePicker!
    
    
    var item : checkoutItem?
    
}
