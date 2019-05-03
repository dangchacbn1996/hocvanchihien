//
//  QuizContentViewController.swift
//  HocVanChiHien
//
//  Created by DC on 5/1/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class QuizContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    static let ID_Identify = "QuizContentViewController"
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var lbTitle : UILabel!
    
    var listQues : ModelQuiz!
    var delegate : GameQuizDelegate!
    var current : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: QuizTableViewCell.NIB_NAME, bundle: nil), forCellReuseIdentifier: QuizTableViewCell.NIB_NAME)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(){
        delegate.backList()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 1 + (delegate.getListQues().listQues?[current].quizAnswer?.count ?? 0)
        return count
    }
    
    func reloadData(){
        lbTitle.text = delegate.getQuesData().listSubject?[delegate.getCurrent()].title ?? "Chủ đề"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizTableViewCell.NIB_NAME, for: indexPath) as! QuizTableViewCell
        cell.selectionStyle = .none
        if (indexPath.row == 0) {
            cell.lbContent.text = delegate.getListQues().listQues?[current].quizQues ?? "Cau hoi"
            cell.lbContent.font = UIFont.boldSystemFont(ofSize: cell.lbContent.font.pointSize)
        } else {
            cell.lbContent.text = delegate.getListQues().listQues?[current].quizAnswer?[indexPath.row - 1] ?? "Cau tra loi"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let correct = delegate.getListQues().listQues?[current].quizCorrect {
            if (indexPath.row == correct) {
                current += 1
                Toast.shared.makeToast(string: "Cau tra loi dung :D", inView: self.view)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2000)) {
                    if (self.current < self.delegate.getListQues().listQues?.count ?? 1) {
                        self.tableView.reloadData()
                    }
                }
            } else {
                Toast.shared.makeToast(string: "Sai rồi :(", inView: self.view)
            }
        }
    }
}
