//
//  CustomUIButton.swift
//  DerivativeIOS
//
//  Created by DC on 1/10/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class CustomUIButton : UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}
