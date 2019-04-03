//
//  ActionMenuViewController.swift
//  HocVanChiHien
//
//  Created by DC on 4/1/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SideMenu

protocol ActionMenuParent {
    func showViewController(viewController : UIViewController, title : String)
}

class ActionMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView : UITableView!
    var parentView : ActionMenuParent?
    var listOption = ["Màn hình chính", "DS đã lưu"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOption.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu", for: indexPath) as! CellMenu
        cell.lbTitle.text = listOption[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            parentView?.showViewController(viewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.vcSaved), title: "DS Đã lưu")
        default:
            parentView?.showViewController(viewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.vcListWeb), title: "GÓC HỌC TẬP")
        }
        self.dismiss(animated: true, completion: nil)
    }
}

class CellMenu : UITableViewCell {
    @IBOutlet weak var lbTitle : UILabel!
}
