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
    
    init?(name: String, group: String, itemType: String, quantity: Int, returnDate: Date, currentDate: Date) {
        
        self.name = name
        self.group = group
        self.itemType = itemType
        self.quantity = quantity
        self.currentDate = currentDate
        self.returnDate = returnDate
    }
    /**
     * Archive this CheckoutClass object
     * @param: fileName from which to archived this object
     */
    func archive(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let encodedItem = try PropertyListEncoder().encode(self)
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(encodedItem, toFile: archiveURL.path)
            if isSuccessfulSave {
                os_log("Item successfully saved to file.", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed to save Item...", log: OSLog.default, type: .error)
            }
        } catch {
            os_log("Failed to save Item...", log: OSLog.default, type: .error)
        }
    }
    
    /**
     * Recover the previously archived Item object
     * @param: fileName from which to recover the previously archived file
     */
    func restore(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        if let recoveredItemCoded = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? Data {
            do {
                let recoveredItem = try PropertyListDecoder().decode(Checkout.self, from: recoveredItemCoded)
                os_log("Item successfully recovered from file.", log: OSLog.default, type: .debug)
                name = recoveredItem.name
                group = recoveredItem.group
                itemType = recoveredItem.itemType
                quantity = recoveredItem.quantity
                returnDate = recoveredItem.returnDate
                currentDate = recoveredItem.returnDate
                
            } catch {
                os_log("Failed to recover Item", log: OSLog.default, type: .error)
            }
        } else {
            os_log("Failed to recover Item", log: OSLog.default, type: .error)
        }
    }
    
}


