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
    let item1 = Item(name: "Pen", currentCount: 5, totalCount : 10)
    let item2 = Item(name: "Pencil", currentCount: 5, totalCount : 10)
    let curDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleItem()
      
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
        cell.itemNameLabel.text = historyItem.itemType.name
        cell.itemQuantityLabel.text = String(historyItem.quantity)
        cell.dateBorrowedLabel.text = String(describing: historyItem.currentDate)
        cell.groupLabel.text = historyItem.group
        cell.returnLabel.text = String(describing: historyItem.returnDate)
        
        return cell
    }
    
    private func loadSampleItem() {
        
        guard let history1 = Checkout(name: "Kevin", group: "MAD", itemType: item1!, quantity: 2, returnDate: curDate, currentDate: curDate) else {fatalError("Unable to instantiate item1")
            }
        
        
        
        guard let history2 = Checkout(name: "Chi", group: "MAD", itemType: item2!, quantity: 3, returnDate: curDate, currentDate: curDate) else {
            fatalError("Unable to instantiate item1")
       }
        
        checkouts += [history1, history2]
        
        
    }
    
}
