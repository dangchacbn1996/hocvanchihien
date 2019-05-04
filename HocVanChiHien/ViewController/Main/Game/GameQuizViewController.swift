//
//  GameQuizViewController.swift
//  HocVanChiHien
//
//  Created by DC on 4/21/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

protocol GameQuizDelegate {
    func getQuesData() -> (ModelQuiz)
    func openQues(index : Int)
    func getListQues() -> (SubModelQuiz)
    func getCurrent() -> (Int)
    func backList()
}

class GameQuizViewController: UIViewController, GameQuizDelegate{
    
    static let ID_Identify = "GameQuizViewController"
    
    @IBOutlet weak var viewList : UIView!
    @IBOutlet weak var viewContent : UIView!
    var viewListQues : GameMainViewController!
    var viewQuesContent : QuizContentViewController!
    var listQues = ModelQuiz()
    var current = 0
    var size : CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
//        if (DataManager.instance)
        var subModel = [DataQuiz(ques : "Câu 1: Câu nào dưới đây không nói về cuộc đời của Hàn Mặc Tử?",

                                      listAnswer : ["A. Sinh năm 1912 tại huyện Phong Lộc, tỉnh Đồng Hới (nay thuộc Quảng Bình), mất năm 1940 tại Quy Nhơn."
                                        , "B. Tên khai sinh là Nguyễn Trọng Trí, làm thơ lấy các bút danh là Hàn Mặc Tử, Minh Duệ Thi, Phong Trần, Lệ Thanh."
                                        , "C. Sinh ra trong một gia đình viên chức nghèo theo đạo Thiên Chúa, có hai năm học trung học ở trường Pe-rơ-lanh."
                                        , "D. Tuy gặp nhiều bất hạnh trong cuộc đời nhưng Hàn Mặc Tử vẫn thể hiện niềm lạc quan đến khâm phục."],
                                      correct : 2),
                             DataQuiz(ques : "Câu 2: Câu nào dưới đây không nói về cuộc đời của Hàn Mặc Tử?",
                                      listAnswer : ["A. Sinh năm 1912 tại huyện Phong Lộc, tỉnh Đồng Hới (nay thuộc Quảng Bình), mất năm 1940 tại Quy Nhơn."
                                        , "B. Tên khai sinh là Nguyễn Trọng Trí, làm thơ lấy các bút danh là Hàn Mặc Tử, Minh Duệ Thi, Phong Trần, Lệ Thanh."
                                        , "C. Sinh ra trong một gia đình viên chức nghèo theo đạo Thiên Chúa, có hai năm học trung học ở trường Pe-rơ-lanh."
                                        , "D. Tuy gặp nhiều bất hạnh trong cuộc đời nhưng Hàn Mặc Tử vẫn thể hiện niềm lạc quan đến khâm phục."],
                                      correct : 1)]
        listQues.listSubject?.append(SubModelQuiz(title : "Đây thôn Vĩ Dạ", listQues : subModel))
        listQues.listSubject?.append(SubModelQuiz(title : "Sóng", listQues : subModel))
        
        viewListQues = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: GameMainViewController.ID_Identify) as! GameMainViewController
        viewListQues.delegate = self
        self.addChild(viewListQues)
        self.viewList.addSubview(viewListQues.view)
        viewListQues.view.frame = CGRect(x: 0, y: 0, width: self.viewList.frame.width, height: self.viewList.frame.height)
        viewListQues.didMove(toParent: self)
        
        viewQuesContent = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: QuizContentViewController.ID_Identify) as! QuizContentViewController
        viewQuesContent.delegate = self
        self.addChild(viewQuesContent)
        self.viewContent.addSubview(viewQuesContent.view)
        viewQuesContent.view.frame = CGRect(x: 0, y: 0, width: self.viewContent.frame.width, height: self.viewContent.frame.height)
        viewQuesContent.didMove(toParent: self)
        viewContent.isHidden = true
        viewContent.alpha = 0
    }
    
    func getQuesData() -> (ModelQuiz) {
        return listQues
     }
    
    func openQues(index: Int) {
        self.current = index
        viewContent.isHidden = false
        UIView.animate(withDuration: 0.25, animations: {
            self.viewList.alpha = 0
            self.viewContent.alpha = 1
            self.viewQuesContent.reloadData()
        }) { (Bool) in
            self.viewList.isHidden = true
        }
    }
    
    func getListQues() -> (SubModelQuiz) {
        return (listQues.listSubject?[current])!
    }
    
    func getCurrent() -> (Int) {
        return current
    }
    
    func backList() {
        viewList.isHidden = false
        UIView.animate(withDuration: 0.25, animations: {
            self.viewList.alpha = 1
            self.viewContent.alpha = 0
        }) { (Bool) in
            self.viewContent.isHidden = true
        }
    }

}
