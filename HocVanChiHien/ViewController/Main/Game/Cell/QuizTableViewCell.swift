//
//  QuizTableViewCell.swift
//  HocVanChiHien
//
//  Created by DC on 4/21/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {
    
    static let NIB_NAME = "QuizTableViewCell"
    
    @IBOutlet weak var lbContent : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
