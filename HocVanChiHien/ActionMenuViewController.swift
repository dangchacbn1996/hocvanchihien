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
//    var listOption = ["Màn hình chính", "DS đã lưu"]
    var listOption = [OptionToSave]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        listOption.append(Constant.AddressInfo.add_GIOI_THIEU)
        listOption.append(Constant.AddressInfo.add_GOC_HOC_TAP)
        listOption.append(Constant.AddressInfo.add_VAN_HOC_THPT)
        listOption.append(Constant.AddressInfo.add_DE_THI_DAI_HOC)
        listOption.append(Constant.AddressInfo.add_SACH_VAN_CHI_HIEN)
        
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
        cell.lbTitle.text = listOption[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.vcListWeb) as! ListWebViewElementsViewController
        viewController.target = listOption[indexPath.row]
        parentView?.showViewController(viewController: viewController, title: listOption[indexPath.row].title)
//        switch indexPath.row {
//        case 1:
//            parentView?.showViewController(viewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.vcSaved), title: "DS Đã lưu")
//        default:
//            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.vcListWeb) as! ListWebViewElementsViewController
//            viewController.target = listOption[indexPath.row]
//            parentView?.showViewController(viewController: viewController, title: listOption[indexPath.row].title)
//        }
        self.dismiss(animated: true, completion: nil)
    }
}

class CellMenu : UITableViewCell {
    @IBOutlet weak var lbTitle : UILabel!
}
