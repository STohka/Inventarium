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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var checkouts = [Checkout]()

    let curDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = tabBarController as! GeneralViewController
        checkouts = tabbar.checkList
         self.tableView.allowsSelection = false
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabbar = tabBarController as! GeneralViewController
        checkouts = tabbar.checkList
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
    
}
