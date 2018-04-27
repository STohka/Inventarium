//
//  HistoryTableViewController.swift
//  Inventarium
//
//  Created by LIU, CHI-YUN on 1/17/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import UIKit
import os.log

class HistoryTableViewController: UITableViewController {
    
    
    var checkouts = [Checkout]()
    var checkIndex : Int = 0
    let curDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalData?.restore(fileName: "saved")
        checkouts = (totalData?.CheckListData)!
         self.tableView.allowsSelection = true
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        totalData?.restore(fileName: "saved")
        checkouts = (totalData?.CheckListData)!
       tableView.reloadData()
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return checkouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "HistoryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HistoryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of HistoryTableViewCell.")
        }
        
        let historyItem = checkouts[indexPath.row]
        cell.NameLabel.text = historyItem.name
        cell.itemNameLabel.text = historyItem.itemType
        cell.itemQuantityLabel.text = String(historyItem.quantity)
        cell.dateBorrowedLabel.text = String(describing: historyItem.currentDate)
        cell.groupLabel.text = historyItem.group
        cell.quantityTag.text = "Quantity"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCheckDetail"{
            
            super.prepare(for: segue, sender: sender)
            guard let itemDetailViewController = segue.destination as? CheckoutDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedItemCell = sender as? HistoryTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedItem = checkouts[indexPath.row]
            itemDetailViewController.checkout = selectedItem
            checkIndex = indexPath.row
        }
        
    }
    
    @IBAction func unwindToCheckoutList(sender: UIStoryboardSegue) {
        }
    
    @IBAction func unwindToCheckoutReturn(sender: UIStoryboardSegue) {
         let tabbar = tabBarController as! GeneralViewController
        if let sourceViewController = sender.source as? CheckoutDetailViewController,
            let item = sourceViewController.checkout {
            
            let curCount  = tabbar.itemList[(item.itemIndex)].currentCount
            let chkCount = tabbar.itemList[item.itemIndex].checkedCount
            tabbar.itemList[(item.itemIndex)].currentCount = curCount + item.quantity
            tabbar.itemList[item.itemIndex].checkedCount = chkCount - item.quantity
            checkouts.remove(at: checkIndex)
            tableView.reloadData()
            tabbar.checkList = checkouts
            
            //persistent data functions
            totalData?.ItemListData = tabbar.itemList
            totalData?.CheckListData = checkouts
            totalData?.archive(fileName: "saved")
        
        }
    }
    @IBAction func unwindToCheckoutReCount(sender: UIStoryboardSegue) {
            let tabbar = tabBarController as! GeneralViewController
            if let sourceViewController = sender.source as? CheckoutDetailViewController,
                let item = sourceViewController.checkout {
                 
                let curCount  = tabbar.itemList[(item.itemIndex)].currentCount
                let chkCount = tabbar.itemList[item.itemIndex].checkedCount
                tabbar.itemList[(item.itemIndex)].currentCount = curCount + sourceViewController.returnCount
                checkouts[checkIndex].quantity = checkouts[checkIndex].quantity - sourceViewController.returnCount
                
                tabbar.itemList[item.itemIndex].checkedCount = chkCount - sourceViewController.returnCount
                
                if (item.quantity == 0)
                {
                    checkouts.remove(at: checkIndex)
                }
                
                tableView.reloadData()
                tabbar.checkList = checkouts
                
                //persistent data functions
                totalData?.ItemListData = tabbar.itemList
                totalData?.CheckListData = checkouts
                totalData?.archive(fileName: "saved")
        
                
            }
    }
    
    
        
        
}
    


    

