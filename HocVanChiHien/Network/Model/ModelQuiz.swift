//
//  ModelQuiz.swift
//  HocVanChiHien
//
//  Created by DC on 4/21/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import Foundation

public class DataQuiz : NSObject, Decodable {
    var quizQues : String?
    var quizAnswer : [String]?
    var quizCorrect : Int?
    
    public init(ques : String, listAnswer : [String], correct : Int) {
        self.quizQues = ques
        self.quizAnswer = listAnswer
        self.quizCorrect = correct
    }
}

//public class SubDataAudioFreeList : NSObject, Decodable {
//    var audioList : [DataAudioFreeList]?
//}

public class ModelQuiz: NSObject, Decodable {
    var listQues: [DataQuiz]?
}
