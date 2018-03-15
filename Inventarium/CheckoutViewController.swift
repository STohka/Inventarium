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
        quantityLabel.text = String(Int(quantityStepper.value))
        quantityStepper.minimumValue = 0
        quantityStepper.maximumValue = Double.infinity
        
    }
    
    func newCheckout(){
        let nameInput = self.nameInput.text ?? ""
        let groupInput = self.groupInput.text ?? ""
        let quantity = quantityStepper.value
        let returnDate = dateInput.date
        let itemInput = self.itemInput.dataSource
        let currentDate = Date()
        newCheck = Checkout (name: nameInput, group: groupInput, itemType: itemInput as! Item, quantity: Int(quantity), returnDate: returnDate, currentDate: currentDate)
    }
    
    @IBAction func quantityStepAction(_ sender: UIStepper) {
         quantityLabel.text = String(Int(quantityStepper.value))
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
    }
    
    
    var newCheck : Checkout?
    
}


