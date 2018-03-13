//
//  HistoryTableViewController.swift
//  Inventarium
//
//  Created by LIU, CHI-YUN on 1/17/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var checkouts = [Checkout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
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

    
}
