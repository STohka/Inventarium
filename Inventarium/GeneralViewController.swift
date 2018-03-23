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
    var checkList = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad() 

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
