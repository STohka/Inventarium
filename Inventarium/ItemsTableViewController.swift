//
//  ItemsTableViewController.swift
//  Inventarium
//
//  Created by LIU, CHI-YUN on 1/17/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import UIKit
import os.log

class ItemsTableViewController: UITableViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addItem: UIBarButtonItem!
    
      var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleItems()
        self.tableView.allowsSelectionDuringEditing = true
        self.tableView.allowsSelection = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "ItemsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ItemsTableViewCell.")
        }
        
        // Fetches the appropriate item for the data source layout.
        let item = items[indexPath.row]
        cell.itemNameLabel.text = item.name
        cell.itemCountLabel.text =  String(item.currentCount) + "/" + String(item.totalCount)
        
        return cell
    }
    

    
    private func loadSampleItems() {
        
        guard let item1 = Item(name: "Caprese Salad", currentCount: 5, totalCount : 10) else {
            fatalError("Unable to instantiate item1")
        }
        
        guard let item2 = Item(name: "Caprese Salad", currentCount: 15, totalCount : 20) else {
            fatalError("Unable to instantiate item1")
        }
        items += [item1, item2]
        
    }
    
    //Actions
    @IBAction func unwindToItemList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewItemViewController,
            let item = sourceViewController.item {
            
  
                // Add a new item.
                let newIndexPath = IndexPath(row: items.count, section: 0)
                
                items.append(item)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
        
        }
        if let EsourceViewController = sender.source as? EditItemViewController,
            let item = EsourceViewController.item {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing item.
                items[selectedIndexPath.row] = item
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            
        }

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if segue.identifier == "EditItem"{
                
                super.prepare(for: segue, sender: sender)
                guard let itemDetailViewController = segue.destination as? EditItemViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let selectedItemCell = sender as? ItemsTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedItem = items[indexPath.row]
                itemDetailViewController.item = selectedItem
            }

        
    }
    
    
    
  





    @IBAction func doEdit(sender: AnyObject) {
        
        if (self.tableView.isEditing) {
            editButton.title = "Edit"
            showAddbutton()
            self.tableView.setEditing(false, animated: true)
        } else {
            editButton.title = "Done"
            hideAddbutton()
            self.tableView.setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .delete
        }
        
        return .none
    }

    
    // For Deleting Items
    
    
    func hideAddbutton() {
        addItem.isEnabled = false
    }
    
    func showAddbutton() {
        addItem.isEnabled = true
    }
    
  }
