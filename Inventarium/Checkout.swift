//
//  Checkout.swift
//  Inventarium
//
//  Created by SUN, KEVIN on 2/21/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Checkout : Codable{
    
    var name : String
    var group : String
    var itemType : String
    var quantity : Int
    var returnDate : Date
    var currentDate : Date
    var itemIndex : Int
    
    init?(name: String, group: String, itemType: String, quantity: Int, returnDate: Date, currentDate: Date, itemIndex: Int) {
        
        self.name = name
        self.group = group
        self.itemType = itemType
        self.quantity = quantity
        self.currentDate = currentDate
        self.returnDate = returnDate
        self.itemIndex = itemIndex
    }
   
    
}


