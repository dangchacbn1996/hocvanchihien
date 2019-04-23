//
//  CellQuizCVC.swift
//  HocVanChiHien
//
//  Created by DC on 4/22/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class CellQuizCVC: UICollectionViewCell {
    
    static let NIB_NAME = "CellQuizCVC"
    @IBOutlet weak var lbContent : UILabel!
    @IBOutlet weak var viewContainer : CustomView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
