//
//  CheckoutDetailViewController.swift
//  Inventarium
//
//  Created by LIU, CHI-YUN on 4/9/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import UIKit

class CheckoutDetailViewController: UIViewController {
    
    var checkout : Checkout?
    var checkoutIndex : Int = 0
    var returnCount : Int = 0
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var GroupLabel: UILabel!
    @IBOutlet weak var ItemLabel: UILabel!
    @IBOutlet weak var QuantityLabel: UILabel!
    @IBOutlet weak var BDateLabel: UILabel!
    @IBOutlet weak var RDateLabel: UILabel!
    @IBOutlet weak var ReturnCountStepper: UIStepper!
    @IBOutlet weak var ReturnCountLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let checkout = checkout {
            NameLabel.text = "Name : " + checkout.name
            GroupLabel.text = "Group : " + checkout.group
            ItemLabel.text = "Borrowed Item : " + checkout.itemType
            QuantityLabel.text = "Quantity : " + String(checkout.quantity)
            BDateLabel.text = "Borrowed Date : " + String(describing: checkout.currentDate)
            RDateLabel.text = "Return Date : " + String(describing: checkout.returnDate)
            ReturnCountStepper.maximumValue = Double(checkout.quantity)
            ReturnCountStepper.value = 1
            ReturnCountLabel.text = String(Int(ReturnCountStepper.value))
            ReturnCountStepper.minimumValue = 1
            returnCount = 1
        }
        
        
    }
 

    @IBAction func ReturnCountAction(_ sender: UIStepper) {
        ReturnCountLabel.text = String(Int(ReturnCountStepper.value))
        returnCount = Int(ReturnCountStepper.value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
