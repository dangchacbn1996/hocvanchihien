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
        case 17011:
            return "Email này chưa được đăng kí nhé!"
        case 17009:
            return "Mật khẩu không đúng kìa!"
        case 17007:
            return "Đã có người sử dụng email này mất rồi!"
        default:
            return "Lỗi chưa xác định!"
        }
    }
}
