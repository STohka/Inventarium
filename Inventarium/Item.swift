//
//  Item.swift
//  Inventarium
//
//  Created by LIU, CHI-YUN on 1/17/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Item : Codable {
    
    var name : String
    var currentCount : Int
    var totalCount : Int
    
    init?(name: String, currentCount: Int, totalCount: Int) {
        self.name = name
        self.currentCount = currentCount
        self.totalCount = totalCount
    }
    
    /**
     * Archive this ItemClass object
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
                let recoveredItem = try PropertyListDecoder().decode(Item.self, from: recoveredItemCoded)
                os_log("Item successfully recovered from file.", log: OSLog.default, type: .debug)
                name = recoveredItem.name
                totalCount = recoveredItem.totalCount
                currentCount = recoveredItem.currentCount

            } catch {
                os_log("Failed to recover Item", log: OSLog.default, type: .error)
            }
        } else {
            os_log("Failed to recover Item", log: OSLog.default, type: .error)
        }
    }
    
}
