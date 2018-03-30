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
    var checkouts = [Checkout]()
    var itemName :String = ""
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var groupInput: UITextField!
    @IBOutlet weak var itemInput: UIPickerView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var dateInput: UIDatePicker!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDoneButton()
    }
    
    //loading & initiates object value
    override func viewDidAppear(_ animated: Bool) {
        let tabbar = tabBarController as! GeneralViewController
        
        nameInput.delegate = self
        groupInput.delegate = self
        itemInput.delegate = self
        itemInput.dataSource = self
        itemList = tabbar.itemList
        
        nameInput.text = ""
        groupInput.text = ""
        quantityStepper.value = 0
        quantityLabel.text = String(Int(quantityStepper.value))
        quantityStepper.minimumValue = 0
        quantityStepper.maximumValue = Double.infinity
        dateInput.minimumDate = Date()
        
       
        
        updateDoneButton()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let tabbar = tabBarController as! GeneralViewController
        tabbar.itemList = itemList
    }
   
    
    
    
    @IBAction func quantityStepAction(_ sender: UIStepper) {
         quantityLabel.text = String(Int(quantityStepper.value))
        updateDoneButton()
    }
    
    
    
    @IBAction func reset(_ sender: UIBarButtonItem) {
        nameInput.text = ""
        groupInput.text = ""
        quantityStepper.value = 0
        quantityLabel.text = String(Int(quantityStepper.value))
        dateInput.date = Date()
        
        
    }
    //button action functions
    @IBAction func done(_ sender: UIBarButtonItem) {
        let tabbar = tabBarController as! GeneralViewController
        tabbar.itemList = itemList
        let nameInput = self.nameInput.text ?? ""
        let groupInput = self.groupInput.text ?? ""
        let quantity = quantityStepper.value
        let returnDate = dateInput.date
        let itemSelected = itemName
        let currentDate = Date()
        newCheck = Checkout (name: nameInput, group: groupInput, itemType: itemSelected, quantity: Int(quantity), returnDate: returnDate, currentDate: currentDate)
        checkouts.append(newCheck!)
        tabbar.checkList.append(newCheck!)
        
        print(tabbar.checkList)
        //reset after new checkout is made
        reset(doneButton)
        
    }
    
    
    //text field functions
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
        updateDoneButton()
    }
    
    
    //picker functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        itemName = itemList[row].name
        quantityStepper.maximumValue = Double(itemList[row].currentCount)
        itemList[row].currentCount = itemList[row].currentCount - Int(quantityStepper.value)
        return (itemList[row].name)
    
    }
    //get selected value
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    //button state
    func updateDoneButton(){
        let name = nameInput.text ?? ""
        if !name.isEmpty && (quantityStepper.value > 0){
            doneButton.isEnabled = true
        }
        else {
            doneButton.isEnabled = false
        }
        
    }
 
    
    
    
    
    var newCheck : Checkout?
    
}


