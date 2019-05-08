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

public class SubModelQuiz: NSObject, Decodable {
    var listQues: [DataQuiz]?
    var title : String?
    
    public init(title : String, listQues : [DataQuiz]) {
        self.title = title
        self.listQues = listQues
    }
}

public class ModelQuiz: NSObject, Decodable {
    var data: String?
}
