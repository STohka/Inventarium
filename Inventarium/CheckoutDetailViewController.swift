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
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var GroupLabel: UILabel!
    @IBOutlet weak var ItemLabel: UILabel!
    @IBOutlet weak var QuantityLabel: UILabel!
    @IBOutlet weak var BDateLabel: UILabel!
    @IBOutlet weak var RDateLabel: UILabel!
    @IBAction func ReturnAll(_ sender: Any) {
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let checkout = checkout {
            NameLabel.text = checkout.name
            GroupLabel.text = checkout.group
            ItemLabel.text = checkout.itemType
            QuantityLabel.text = String(checkout.quantity)
            BDateLabel.text = ""
            RDateLabel.text = ""
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
