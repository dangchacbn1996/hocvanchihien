//
//  FirebaseConstant.swift
//  HocVanChiHien
//
//  Created by DC on 4/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

struct FirebaseConstant {
    static func checkCodeError(code : Int) -> (String){
        switch code {
        case 17009:
            return "Mật khẩu không đúng!"
        default:
            return "Tài khoản không tồn tại!"
        }
    }
}
