//
//  DataManager.swift
//  HocVanChiHien
//
//  Created by ChacND_HAV on 4/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class DataManager {
    var userID = ""
    var userEmail = ""
    static let instance = DataManager()
    var userInfo : ModelUserInfo?
    var listAudio : ModelAudioFreeList?
    
    private init(){
    }
    
//    func getUserID() -> (String) {
//        return userInfo.
//    }
}
