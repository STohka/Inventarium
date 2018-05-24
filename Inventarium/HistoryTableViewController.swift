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
    @IBOutlet weak var SortingTabs: UISegmentedControl!
    
    
    var checkouts = [Checkout]()
    var checkIndex : Int = 0
    let curDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalData?.restore(fileName: "saved")
        checkouts = (totalData?.CheckListData)!
         self.tableView.allowsSelection = true
      
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        totalData?.restore(fileName: "saved")
        checkouts = (totalData?.CheckListData)!
        SortingTabs.selectedSegmentIndex = 3
       tableView.reloadData()
        
       
    }

    @IBAction func SortingAction(_ sender: Any) {
        if SortingTabs.selectedSegmentIndex == 0{
            print("sort name")
            checkouts.sort(by: { $0.name < $1.name })
             tableView.reloadData()
        }
        else if SortingTabs.selectedSegmentIndex == 1{
            checkouts.sort(by: { $0.group < $1.group})
             tableView.reloadData()
        }
        else if SortingTabs.selectedSegmentIndex == 2{
            checkouts.sort(by: { $0.itemType < $1.itemType })
             tableView.reloadData()
        }
        else if SortingTabs.selectedSegmentIndex == 3{
            checkouts.sort(by: { $0.currentDate < $1.currentDate })
             tableView.reloadData()
        }
        else if SortingTabs.selectedSegmentIndex == 4{
            checkouts.sort(by: { $0.returnDate < $1.returnDate })
             tableView.reloadData()
        }
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
        if SortingTabs.selectedSegmentIndex == 0{
            return checkouts.count
        }
        else if SortingTabs.selectedSegmentIndex == 1{
            return checkouts.count
        }
        else if SortingTabs.selectedSegmentIndex == 2{
            return checkouts.count
        }
        else if SortingTabs.selectedSegmentIndex == 3{
            return checkouts.count
        }
        else if SortingTabs.selectedSegmentIndex == 4{
            return checkouts.count
        }
        return checkouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "HistoryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HistoryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of HistoryTableViewCell.")
        }
        
        let historyItem = checkouts[indexPath.row]
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        let Cdate = dateFormat.string(from: historyItem.currentDate)
        let Rdate = dateFormat.string(from: historyItem.returnDate)
        
        cell.NameLabel.text = historyItem.name
        cell.itemNameLabel.text = historyItem.itemType
        cell.itemQuantityLabel.text = String(historyItem.quantity)
        cell.dateBorrowedLabel.text = Cdate
        cell.returnDateLabel.text = Rdate
        cell.groupLabel.text = historyItem.group
        cell.quantityTag.text = "Quantity"
        if(cell.groupLabel.text == "")
        {
            cell.groupLabel.text = "None"
            cell.groupLabel.textColor = UIColor.gray
        }
        else
        {
            cell.groupLabel.textColor = UIColor.black
        }
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
        let itemList = totalData?.ItemListData
        if let sourceViewController = sender.source as? CheckoutDetailViewController,
            let item = sourceViewController.checkout {
            item.itemIndex = sourceViewController.checkoutIndex
            let curCount  = itemList![(item.itemIndex)].currentCount
            let chkCount = itemList![item.itemIndex].checkedCount
            itemList![(item.itemIndex)].currentCount = curCount + item.quantity
            itemList![item.itemIndex].checkedCount = chkCount - item.quantity
            checkouts.remove(at: checkIndex)
            tableView.reloadData()
            
            //persistent data functions
            totalData?.ItemListData = itemList!
            totalData?.CheckListData = checkouts
            totalData?.archive(fileName: "saved")
        
        }
    }
    @IBAction func unwindToCheckoutReCount(sender: UIStoryboardSegue) {

        let itemList = totalData?.ItemListData
            if let sourceViewController = sender.source as? CheckoutDetailViewController,
                let item = sourceViewController.checkout {
                item.itemIndex = sourceViewController.checkoutIndex
                let curCount  = itemList![(item.itemIndex)].currentCount
                let chkCount = itemList![item.itemIndex].checkedCount
                itemList![(item.itemIndex)].currentCount = curCount + sourceViewController.returnCount
                checkouts[checkIndex].quantity = checkouts[checkIndex].quantity - sourceViewController.returnCount
                
                itemList![item.itemIndex].checkedCount = chkCount - sourceViewController.returnCount
                
                if (item.quantity == 0)
                {
                    checkouts.remove(at: checkIndex)
                }
                
                tableView.reloadData()
                
                //persistent data functions
                totalData?.ItemListData = itemList!
                totalData?.CheckListData = checkouts
                totalData?.archive(fileName: "saved")
        
                
            }
    }
    
    
        
        
}
    


    

