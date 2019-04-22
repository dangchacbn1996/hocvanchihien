//
//  GameQuizViewController.swift
//  HocVanChiHien
//
//  Created by DC on 4/21/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class GameQuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var listQues = ModelQuiz()
    var current = 0
    
    @IBOutlet weak var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        listQues.listQues = [DataQuiz(ques : "Câu 1: Câu nào dưới đây không nói về cuộc đời của Hàn Mặc Tử?",
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: QuizTableViewCell.NIB_NAME, bundle: nil), forCellReuseIdentifier: QuizTableViewCell.NIB_NAME)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 1 + (listQues.listQues?[current].listAnswer?.count ?? 0)
        return count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if (indexPath.row == 0) {
//            return
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizTableViewCell.NIB_NAME, for: indexPath) as! QuizTableViewCell
        cell.selectionStyle = .none
        if (indexPath.row == 0) {
            cell.lbContent.text = listQues.listQues?[current].ques ?? "Cau hoi"
            cell.lbContent.font = UIFont.boldSystemFont(ofSize: cell.lbContent.font.pointSize)
        } else {
            cell.lbContent.text = listQues.listQues?[current].listAnswer?[indexPath.row - 1]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let correct = listQues.listQues?[current].correct {
            if (indexPath.row == correct) {
                current += 1
                Toast.shared.makeToast(string: "Cau tra loi dung :D", inView: self.view)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2000)) {
                    if (self.current < self.listQues.listQues!.count) {
                        self.tableView.reloadData()
                    }
                }
                
            } else {
                Toast.shared.makeToast(string: "Sai rồi :(", inView: self.view)
            }
        }
    }
    

}
