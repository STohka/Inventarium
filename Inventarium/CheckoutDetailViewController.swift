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
    @IBOutlet weak var button: UIBarButtonItem!
    
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
            totalData?.restore(fileName: "saved")
            
            let dateFormat = DateFormatter()
            dateFormat.dateStyle = .short
            let Cdate = dateFormat.string(from: checkout.currentDate)
            let Rdate = dateFormat.string(from: checkout.returnDate)
            
            let count: Int = (totalData?.ItemListData.count)!
            var itemName: Array<String?> = Array(repeating: nil, count: count
            )
            for i in 0...(count - 1){
                itemName[i] = (totalData?.ItemListData[i].name)!
                print(itemName.count)
                print(itemName[i])
            }
            NameLabel.text = "Name : " + checkout.name
            ItemLabel.text = "Borrowed Item : " + checkout.itemType
            QuantityLabel.text = "Quantity : " + String(checkout.quantity)
            BDateLabel.text = "Borrowed Date : " + Cdate
            RDateLabel.text = "Return Date : " + Rdate
            ReturnCountStepper.maximumValue = Double(checkout.quantity)
            ReturnCountStepper.value = 1
            ReturnCountLabel.text = String(Int(ReturnCountStepper.value))
            ReturnCountStepper.minimumValue = 1
            returnCount = 1
            if(checkout.group == "")
            {
                GroupLabel.text = "Group : None"
                GroupLabel.textColor = UIColor.gray
            }
            else
            {
                GroupLabel.text = "Group : " + checkout.group
            }
            
            for i in 0...(count - 1)
            {
                if (itemName[i] == checkout.itemType)
                {
                    checkoutIndex = i
                    
                }
            }
            print(checkoutIndex)
        }
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
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
