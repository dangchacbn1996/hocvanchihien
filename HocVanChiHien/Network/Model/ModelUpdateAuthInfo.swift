//
//  CreateNewAuthModel.swift
//  HocVanChiHien
//
//  Created by ChacND_HAV on 4/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

public class DataUpdateAuthInfo : NSObject, Decodable {
    var _seconds : Double?
    var _nanoseconds : Double?
}

public class ModelUpdateAuthInfo : NSObject, Decodable {
    var _writeTime : DataUpdateAuthInfo?
}
