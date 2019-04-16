//
//  CellNewsTableViewCell.swift
//  HocVanChiHien
//
//  Created by DC on 4/16/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class CellNewsTableViewCell: UITableViewCell {
    
    static let cellID = "CellNewsTableViewCell"
    
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var content : UILabel!
    @IBOutlet weak var btnSave : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
