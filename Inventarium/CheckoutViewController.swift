//
//  CheckoutViewController.swift
//  Inventarium
//
//  Created by SUN, KEVIN on 2/21/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import UIKit
import os.log

class CheckoutViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    
    var itemList = [Item]()
    
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
        itemInput.delegate = self
        
        quantityStepper.value = 0
        quantityLabel.text = String(Int(quantityStepper.value))
        quantityStepper.minimumValue = 0
        quantityStepper.maximumValue = Double.infinity
        dateInput.minimumDate = Date()
        
        let itemTVC = ItemsTableViewController(nibName: "ItemsTableViewController", bundle: nil)
        itemList = itemTVC.items
        itemInput.dataSource = self
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
    
    @IBAction func reset(_ sender: UIBarButtonItem) {
        nameInput.text = ""
        groupInput.text = ""
        quantityStepper.value = 0
        quantityLabel.text = String(Int(quantityStepper.value))
        dateInput.date = Date()
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        doneButton.isEnabled = false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func pickerView(pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return itemList[row].name
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return itemList.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemList.count
    }
 
    
    
    
    var newCheck : Checkout?
    
}


