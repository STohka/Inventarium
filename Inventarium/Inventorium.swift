//
//  Inventorium.swift
//  Inventarium
//
//  Created by LIU, CHI-YUN on 4/16/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Inventorium: Codable {
    var CheckListData = [Checkout]()
    var ItemListData = [Item]()
    
    init?(CheckListData : [Checkout], ItemListData : [Item]) {
        self.CheckListData = CheckListData
        self.ItemListData = ItemListData
    }
    
    // ********** You should not have to change ANYTHING in "func archive()" to use *************
    /**
     * Archive this Inventorium object
     * @param: fileName from which to archived this object
     */
    func archive(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let encodedData = try PropertyListEncoder().encode(self)
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(encodedData, toFile: archiveURL.path)
            if isSuccessfulSave {
                os_log("Data successfully saved to file.", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed to save data...", log: OSLog.default, type: .error)
            }
        } catch {
            os_log("Failed to save data...", log: OSLog.default, type: .error)
        }
    }
    
    // ********** Replace "Inventorium" in this function with your class's name *************
    // ********** Restore the recovered values into object's current values *************
    /**
     * Recover the previously archived MeetClass object
     * @param: fileName from which to recover the previously archived file
     */
    func restore(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        if let recoveredDataCoded = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? Data {
            do {
                // *** Replace "Inventorium" on the next line with the name of the class to be persistent. ***
                let recoveredData = try PropertyListDecoder().decode(Inventorium.self, from: recoveredDataCoded)
                os_log("Data successfully recovered from file.", log: OSLog.default, type: .debug)
                // *** Replace all the assignment statements BELOW to "restore" all properties of the object ***
                CheckListData = recoveredData.CheckListData
                ItemListData = recoveredData.ItemListData
                // *** Replace all the assignment statements ABOVE to "restore" all properties of the object ***
            } catch {
                os_log("Failed to recover data", log: OSLog.default, type: .error)
            }
        } else {
            os_log("Failed to recover data", log: OSLog.default, type: .error)
        }
    }
}
