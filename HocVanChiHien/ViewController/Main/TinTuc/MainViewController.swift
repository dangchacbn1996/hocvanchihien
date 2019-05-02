//
//  DemoWebViewViewController.swift
//  WeConnectIOS
//
//  Created by ChacND_HAV on 3/29/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import WebKit
import DropDown

class MainViewController : UIViewController, ActionMenuParent{
    
    @IBOutlet weak var lbTitle : UILabel!
    @IBOutlet weak var tfSearch : UITextField!
    @IBOutlet weak var viewContainer : UIView!
    @IBOutlet weak var viewOption : UIView!
    var dropList = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropList.anchorView = viewOption
        dropList.dataSource = [Constant.AddressInfo.getWebInfo(type: Constant.AddressInfo.add_GIOI_THIEU, page: 0).title,
                               Constant.AddressInfo.getWebInfo(type: Constant.AddressInfo.add_GOC_HOC_TAP, page: 0).title,
                               Constant.AddressInfo.getWebInfo(type: Constant.AddressInfo.add_VAN_HOC_THPT, page: 0).title,
                               Constant.AddressInfo.getWebInfo(type: Constant.AddressInfo.add_DE_THI_DAI_HOC, page: 0).title,
                               Constant.AddressInfo.getWebInfo(type: Constant.AddressInfo.add_SACH_VAN_CHI_HIEN, page: 0).title]
        dropList.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lbTitle.text = item
            if (self.children.last is ListWebViewElementsViewController) {
                if ((self.children.last as! ListWebViewElementsViewController).index == index) {
                    return
                }
            }
            let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idListBoxWebViewVC") as! ListWebViewElementsViewController
            viewController.index = index
            self.showViewController(viewController: viewController, title: item)
        }
        tfSearch.addTarget(self, action: #selector(searchItem(_:)), for: UIControl.Event.editingChanged)
        showViewController(viewController: UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idListBoxWebViewVC"), title: "TRANG CHỦ")
    }
    
    @IBAction func openListOption(){
        dropList.show()
    }
    
//    @IBAction func openMenu(){
//        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
//    }
    
    @objc func searchItem(_ textField : UITextField) {
        (self.children.first as? MainSubViewController)?.searchResult(string: textField.text ?? "")
    }
    
    func showViewController(viewController : UIViewController, title : String) {
//        Loading.sharedInstance.show(in: <#T##UIView#>)
        lbTitle.text = title
        UIView.animate(withDuration: 0.1, animations: {
            self.viewContainer.alpha = 0
        }) { (success) in
            self.viewContainer.subviews.forEach { (view) in
                view.removeFromSuperview()
            }
            self.children.forEach { (vc) in
                vc.removeFromParent()
            }
            self.viewContainer.addSubview(viewController.view)
            viewController.view.frame = self.viewContainer.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.didMove(toParent: self)
            self.addChild(viewController)
            UIView.animate(withDuration: 0.1, animations: {
                self.viewContainer.alpha = 1
            })
        }
    }
}

struct Option {
    var href : String
    var title : String
    var html : String
    var url : URL?
}

struct ListSaved : Codable {
    var listSaved : [OptionToSave]
    
    init() {
        listSaved = [OptionToSave]()
    }
}

protocol MainSubViewController {
    func searchResult(string : String)
}
