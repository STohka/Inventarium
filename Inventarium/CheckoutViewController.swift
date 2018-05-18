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
    
    
    
   
    var itemListCopy = [Item]()
    var checkouts = [Checkout]()
    var itemName :String = ""
    var itemIndex : Int  = 0
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var groupInput: UITextField!
    @IBOutlet weak var itemInput: UIPickerView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var dateInput: UIDatePicker!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalData?.restore(fileName: "saved")
        updateDoneButton()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    //loading & initiates object value
    override func viewDidAppear(_ animated: Bool) {
        
        //load old data
        totalData?.restore(fileName: "saved")
        
        nameInput.delegate = self
        groupInput.delegate = self
        itemInput.delegate = self
        itemInput.dataSource = self
        itemListCopy = (totalData?.ItemListData)!
        checkouts = (totalData?.CheckListData)!
        nameInput.text = ""
        groupInput.text = ""
        quantityStepper.value = 0
        quantityLabel.text = String(Int(quantityStepper.value))
        quantityStepper.minimumValue = 0
        dateInput.minimumDate = Date()
        
        itemInput.selectRow(0, inComponent: 0, animated: true)
        itemIndex = 0
        if(itemListCopy.count > 0)
        {
        quantityStepper.maximumValue = Double(itemListCopy[0].currentCount)
        }
        else{
            quantityStepper.maximumValue = 0
        }
        
        updateDoneButton()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        totalData?.ItemListData = itemListCopy
        totalData?.archive(fileName: "saved")
        
       
        
    }
   
    
    
    
    @IBAction func quantityStepAction(_ sender: UIStepper) {
         quantityLabel.text = String(Int(quantityStepper.value))
        updateDoneButton()
    }
    
    
    
    @IBAction func reset(_ sender: UIBarButtonItem) {
        nameInput.text = ""
        groupInput.text = ""
        quantityStepper.value = 0
        itemInput.selectRow(0, inComponent: 0, animated: true)
        quantityStepper.maximumValue = Double(itemListCopy[0].currentCount)
        itemIndex = 0
        quantityLabel.text = String(Int(quantityStepper.value))
        dateInput.date = Date()
        
        
    }
    //button action functions
    @IBAction func done(_ sender: UIBarButtonItem) {
        
        
        var itemList = totalData?.ItemListData
        totalData?.ItemListData = itemListCopy
        let nameInput = self.nameInput.text ?? ""
        let groupInput = self.groupInput.text ?? ""
        let quantity = quantityStepper.value
        let returnDate = dateInput.date
        let itemSelected = itemListCopy[itemIndex].name
        let currentDate = Date()
        newCheck = Checkout (name: nameInput, group: groupInput, itemType: itemSelected, quantity: Int(quantity), returnDate: returnDate, currentDate: currentDate, itemIndex : itemIndex)
        checkouts.insert((newCheck!), at: 0)
        
        itemList![itemIndex].currentCount = itemListCopy[itemIndex].currentCount - Int(quantityStepper.value)
        itemList![itemIndex].checkedCount = itemListCopy[itemIndex].checkedCount + Int(quantity)
        
        itemList = itemListCopy
        
        let alert = UIAlertController(title: "Checkout Sucessful", message: "You have made " + String(Int(quantity)) + " checkout to " + itemSelected, preferredStyle: .alert)
        
        //persistent data functions
        totalData?.ItemListData = itemListCopy
        totalData?.CheckListData = checkouts
        totalData?.archive(fileName: "saved")
        
        
        //reset after new checkout is made
        reset(doneButton)
        updateDoneButton()
        itemInput.selectRow(0, inComponent: 0, animated: true)
        quantityStepper.maximumValue = Double(itemListCopy[0].currentCount)
        itemIndex = 0
        dateInput.date = Date()
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
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
        return itemListCopy.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        itemName = itemListCopy[row].name
         quantityStepper.maximumValue = Double(itemListCopy[row].currentCount)
        quantityStepper.value = 0
        quantityLabel.text = String(Int(quantityStepper.value))
        updateDoneButton()
        return (itemListCopy[row].name)
    
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        itemIndex = row
        if(itemListCopy.count > 0)
        {
        quantityStepper.maximumValue = Double(itemListCopy[row].currentCount)
        }
        else
        {
            quantityStepper.maximumValue = 0
            updateDoneButton()
        }
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
        
        if (itemListCopy.count == 0)
        {
            doneButton.isEnabled = false
        }
        
        
    }
 
    
    
    
    
    var newCheck : Checkout?
    
}


