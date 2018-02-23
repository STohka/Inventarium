//
//  checkoutItem.swift
//  Inventarium
//
//  Created by SUN, KEVIN on 2/21/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import Foundation
import UIKit

class checkoutItem {
    
    var name : String
    var classperiod : Int
    var typeofitem : Item
    var quantity : Int
    var returndate : Date
    
    init?(name: String, classperiod: Int, typeofitem: Item, quantity: Int, returndate: Date) {
        
        self.name = name
        self.classperiod = classperiod
        self.typeofitem = typeofitem
        self.quantity = quantity
        self.returndate = returndate
    }
}
