//
//  HistoryTableViewCell.swift
//  Inventarium
//
//  Created by Chi on 3/13/18.
//  Copyright © 2018 LIU, CHI-YUN. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    @IBOutlet weak var dateBorrowedLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var returnLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
