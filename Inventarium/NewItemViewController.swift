//
//  NewItemViewController.swift
//  Inventarium
//
//  Created by LIU, CHI-YUN on 1/18/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import UIKit
import os.log

class NewItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var itemNameInput: UITextField!
    @IBOutlet weak var itemNumberInput: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    var item : Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameInput.delegate = self
        itemNumberInput.delegate = self
        self.itemNumberInput.inputView = LNNumberpad.default()

        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    override open var shouldAutorotate: Bool {
        return false
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
        let currentCount = Int(itemNumberInput.text!)
        let totalCount = Int(itemNumberInput.text!)
        
        item = Item(name : name, currentCount : currentCount!, totalCount : totalCount!, checkedCount : 0)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
        
    }
    
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = itemNameInput.text ?? ""
        let number = itemNumberInput.text ?? ""

        if !number.isEmpty && !text.isEmpty{
        saveButton.isEnabled = true
        }
        else
        {
            saveButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let count: Int = (totalData?.ItemListData.count)!
        let alert = UIAlertController(title: "Notice", message: "This item has already exist.", preferredStyle: .alert)
        alert.view.tintColor = UIColor.gray
        for i in 0...(count - 1){
            if (totalData?.ItemListData[i].name == itemNameInput.text)
            {
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                saveButton.isEnabled = false
            }
            else {
                updateSaveButtonState()
            }
        }
       
        
    }


    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
