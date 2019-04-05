//
//  Constant.swift
//  HocVanChiHien
//
//  Created by DC on 4/2/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

struct Constant {
    static let storyMain = "Main"
    struct idViewController {
        static let vcListWeb = "idListBoxWebViewVC"
        static let vcDetail = "detailContentVC"
        static let vcSaved = "vcSavedList"
    }
    
    struct AddressInfo {
        static let add_GOC_HOC_TAP = OptionToSave(url: URL(string: "http://hocvanchihien.com/"),
                                                  title: "Góc học tập")
        static let add_GIOI_THIEU = OptionToSave(url: URL(string: "http://hocvanchihien.com/Vn/Gioi-thieu-ListNews-1-16"),
                                                 title: "Giới thiệu")
        static let add_VAN_HOC_THPT = OptionToSave(url: URL(string: "http://hocvanchihien.com/Vn/Van-hoc-THPT-ListNews-1-45"),
                                                   title: "Văn học THPT")
        static let add_DE_THI_DAI_HOC = OptionToSave(url: URL(string: "http://hocvanchihien.com/Vn/De-Thi-Dai-Hoc-ListNews-1-1060"),
                                                     title: "Đề thi đại học")
        static let add_SACH_VAN_CHI_HIEN = OptionToSave(url: URL(string: "http://hocvanchihien.com/Vn/Sach-Van-Chi-Hien-ListNews-1-42"),
                                                        title: "Sách văn chị Hiên")
    }
}

struct OptionToSave : Codable{
    var url : URL?
    var title : String
}
