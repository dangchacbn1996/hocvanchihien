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
    @IBOutlet weak var avatar : CustomImageView!
    var parentView : ActionMenuParent?
    var listOption = [String]()
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        listOption.append("Cài đặt")
        listOption.append("Đăng xuất")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        avatar.layer.cornerRadius = 0.5 * avatar.frame.height
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
        if (indexPath.row == listOption.count - 1) {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.vcSaved) as! SavedListPosts
            parentView?.showViewController(viewController: viewController, title: listOption[indexPath.row])
            self.dismiss(animated: true, completion: nil)
            return
        }
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.vcListWeb) as! ListWebViewElementsViewController
        viewController.index = indexPath.row
        parentView?.showViewController(viewController: viewController, title: listOption[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}

class CellMenu : UITableViewCell {
    @IBOutlet weak var lbTitle : UILabel!
}
