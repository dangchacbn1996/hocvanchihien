//
//  ModelQuiz.swift
//  HocVanChiHien
//
//  Created by DC on 4/21/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import Foundation

public class DataQuiz : NSObject, Decodable {
    var ques : String?
    var listAnswer : [String]?
    var correct : Int?
    
    public init(ques : String, listAnswer : [String], correct : Int) {
        self.ques = ques
        self.listAnswer = listAnswer
        self.correct = correct
    }
}

//public class SubDataAudioFreeList : NSObject, Decodable {
//    var audioList : [DataAudioFreeList]?
//}

public class ModelQuiz: NSObject, Decodable {
    var listQues: [DataQuiz]?
}
