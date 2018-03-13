//
//  CheckoutViewController.swift
//  Inventarium
//
//  Created by SUN, KEVIN on 2/21/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import UIKit
import os.log

class CheckoutViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var groupInput: UITextField!
    @IBOutlet weak var itemInput: UIPickerView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var dateInput: UIDatePicker!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameInput.delegate = self
        groupInput.delegate = self
        quantityStepper.value = 0
        quantityStepper.minimumValue = 0
        quantityStepper.maximumValue = Double.infinity
        
    }
    
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
    }
    
    
    var item : Checkout?
    
}


