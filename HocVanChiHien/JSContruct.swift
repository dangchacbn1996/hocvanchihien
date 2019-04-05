//
//  JSContruct.swift
//  HocVanChiHien
//
//  Created by DC on 3/31/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

struct JSContruct {
    struct BoxNewsEvent {
        static let EventTime = 0
        static let EventImg = 1
        static let EventTitle = 2
        static let getContent = ".children[0].children[2].children[2].innerText;"
        static let getHomePageContent = ".children[1].innerText;"
        struct EventTitleSub {
            static let h4ContainTitle = 1
            static let h4SubA = 0
            static let h4Content = 2
        }
    }
}
