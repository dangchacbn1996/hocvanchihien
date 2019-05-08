//
//  GameQuizViewController.swift
//  HocVanChiHien
//
//  Created by DC on 4/21/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

protocol GameQuizDelegate {
    func getQuesData() -> ([SubModelQuiz])
    func openQues(index : Int)
    func getListQues() -> (SubModelQuiz)
    func getCurrent() -> (Int)
    func backList()
    func completeLesson()
}

class GameQuizViewController: UIViewController, GameQuizDelegate{
    
    static let ID_Identify = "GameQuizViewController"
    
    @IBOutlet weak var viewList : UIView!
    @IBOutlet weak var viewContent : UIView!
    var viewListQues : GameMainViewController!
    var viewQuesContent : QuizContentViewController!
    var listQues = ModelQuiz()
    var data = [SubModelQuiz]()
    var current = 0
    var size : CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        data = DataManager.instance.listQues ?? [SubModelQuiz]()
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
    
    func getQuesData() -> ([SubModelQuiz]) {
        return data
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
        return data[current]
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
    
    func completeLesson() {
        backList()
        (viewListQues.collectionView.cellForItem(at: IndexPath(item: current, section: 0)) as! CellQuizCVC).viewContainer.backgroundColor = UIColor(hexString: "A5D6A7")
        Toast.shared.makeToast(string: "Đã hoàn thành bài học", inView: self.view)
    }

}
