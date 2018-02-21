//
//  Item.swift
//  Inventarium
//
//  Created by LIU, CHI-YUN on 1/17/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import Foundation
import UIKit

class Item {
    
    var name : String
    var currentCount : Int
    var totalCount : Int
    
    init?(name: String, currentCount: Int, totalCount: Int) {
        self.name = name
        self.currentCount = currentCount
        self.totalCount = totalCount
    }
}
