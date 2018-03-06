//
//  NewItemViewController.swift
//  Inventarium
//
//  Created by LIU, CHI-YUN on 1/18/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import UIKit
import os.log

class EditItemViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var itemNameInput: UITextField!
    @IBOutlet weak var totalItemCountInput: UITextField!
    @IBOutlet weak var currentItemCountInput: UITextField!
    @IBOutlet weak var totalItemCountStepper: UIStepper!
    @IBOutlet weak var currentItemCountStepper: UIStepper!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    


    
    var item : Item?
    var originalTotal : Int = 0
    var originalCurrent : Int = 0
    var originalName : String  = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalItemCountInput.inputView = LNNumberpad.default()
        self.currentItemCountInput.inputView = LNNumberpad.default()

        itemNameInput.delegate = self
        totalItemCountInput.delegate = self
        currentItemCountInput.delegate = self
        

        
        if let item = item {
            navigationItem.title = item.name
            itemNameInput.text = item.name
            totalItemCountInput.text = String (item.totalCount)
            currentItemCountInput.text = String (item.currentCount)
            totalItemCountStepper.maximumValue = Double.infinity
            currentItemCountStepper.maximumValue = Double.infinity
            totalItemCountStepper.value = Double(item.totalCount)
            currentItemCountStepper.value = Double(item.currentCount)
       
        }

        originalName = (item?.name)!
        originalTotal = (item?.totalCount)!
        originalCurrent = (item?.currentCount)!
        
        // Enable the Save button only if the text field has a valid Item name.
        updateSaveButtonState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = itemNameInput.text ?? ""
        let currentCount = Int(currentItemCountInput.text!)
        let totalCount = Int(totalItemCountInput.text!)
        item?.currentCount = currentCount!
        item?.totalCount = totalCount!
        item?.name = name
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
        
    }
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = itemNameInput.text ?? ""
        let number = totalItemCountInput.text ?? ""
        let isName = !text.isEmpty
        let isNumber = !number.isEmpty
        saveButton.isEnabled = isName && isNumber
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        
    }
    
    @IBAction func totalStepAction(_ sender: UIStepper) {
        item?.totalCount = Int(sender.value)
        totalItemCountInput.text = String (describing: item!.totalCount)
        
    }
    
    @IBAction func currentStepAction(_ sender: UIStepper) {
        currentItemCountStepper.maximumValue = Double ((item?.totalCount)!)
        item?.currentCount = Int(sender.value)
        currentItemCountInput.text = String (describing: item!.currentCount)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        item?.currentCount = originalCurrent
        item?.name = originalName
        item?.totalCount = originalTotal
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func saveUpdate(_ sender: UIBarButtonItem){
        
    }
    
}
