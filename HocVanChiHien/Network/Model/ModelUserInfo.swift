//
//  UserInfoModel.swift
//  HocVanChiHien
//
//  Created by ChacND_HAV on 4/10/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

public class ModelUserInfo : NSObject, Decodable {
    var audioPermission : [String]?
    var name : String?
    var phone : String?
    var point : Int?
    var paymentAudio : [String]?
}

