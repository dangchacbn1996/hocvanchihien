//
//  ModelAudioFreeList.swift
//  HocVanChiHien
//
//  Created by ChacND_HAV on 4/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import Foundation

public class DataAudioFreeList : NSObject, Decodable {
    var audioContent : String?
    var audioName : String?
    var audioUrl : String?
    var audioImage : String?
}

//public class SubDataAudioFreeList : NSObject, Decodable {
//    var audioList : [DataAudioFreeList]?
//}

public class ModelAudioFreeList: NSObject {
    let listAudio: [DataAudioFreeList]?
    
    init(data : [DataAudioFreeList]) {
        self.listAudio = data
    }
}
