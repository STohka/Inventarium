//
//  GeneralViewController.swift
//  Inventarium
//
//  Created by LIU, CHI-YUN on 3/21/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import Foundation
import UIKit
import os.log

class GeneralViewController: UITabBarController{
    
    var itemList = [Item]()
    var checkList = [Checkout]()
    var totalData = Inventorium(CheckListData: [Checkout](), ItemListData: [Item]())
    override func viewDidLoad() {
        super.viewDidLoad()
        var item1 = Item(name: "Item Sample 1", currentCount: 5, totalCount : 10)
        var item2 = Item(name: "Item Sample 2", currentCount: 15, totalCount : 20)
        itemList = [item1!, item2!]
        totalData?.ItemListData = itemList
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
