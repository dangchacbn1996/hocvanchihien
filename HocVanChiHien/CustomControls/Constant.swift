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
    static let storyLogin = "Login"
    struct idLoginViewController {
        static let vcLogin = "vc_login_view"
        static let vcRegister = "vc_register_view"
    }
    struct idViewController {
        static let vcListWeb = "idListBoxWebViewVC"
        static let vcDetail = "detailContentVC"
        static let vcSaved = "vcSavedList"
        static let vcMain = "main_view_controller"
        struct idAudioTab {
            static let vcListFree = "vc_list_audio_free"
            static let vcPlayer = "vc_audio_player"
        }
    }
    
    struct AddressInfo {
        static func getWebInfo(type : Int, page : Int) -> (OptionToSave){
            switch type {
            case add_GIOI_THIEU:
                return OptionToSave(url: URL(string: "http://hocvanchihien.com/"),
                             title: "Góc học tập")
            case add_GOC_HOC_TAP:
                return OptionToSave(url: URL(string: "http://hocvanchihien.com/Vn/Gioi-thieu-ListNews-\(page + 1)-16"),
                                    title: "Giới thiệu")
            case add_VAN_HOC_THPT:
                return OptionToSave(url: URL(string: "http://hocvanchihien.com/Vn/Van-hoc-THPT-ListNews-\(page + 1)-45"),
                                    title: "Văn học THPT")
            case add_DE_THI_DAI_HOC:
                return OptionToSave(url: URL(string: "http://hocvanchihien.com/Vn/De-Thi-Dai-Hoc-ListNews-\(page + 1)-1060"),
                                    title: "Đề thi đại học")
            case add_SACH_VAN_CHI_HIEN:
                return OptionToSave(url: URL(string: "http://hocvanchihien.com/Vn/Sach-Van-Chi-Hien-ListNews-\(page + 1)-42"),
                                    title: "Sách văn chị Hiên")
            default:
                return OptionToSave(url: URL(string: "http://hocvanchihien.com/"),
                                    title: "Góc học tập")
            }
        }
        static let add_GIOI_THIEU = 0
        static let add_GOC_HOC_TAP = 1
        static let add_VAN_HOC_THPT = 2
        static let add_DE_THI_DAI_HOC = 3
        static let add_SACH_VAN_CHI_HIEN = 4
    }
}

struct OptionToSave : Codable{
    var url : URL?
    var title : String
}
