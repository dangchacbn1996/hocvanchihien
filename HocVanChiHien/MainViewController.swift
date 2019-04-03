//
//  DemoWebViewViewController.swift
//  WeConnectIOS
//
//  Created by ChacND_HAV on 3/29/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import WebKit
import SideMenu

class MainViewController : UIViewController, ActionMenuParent{
    
    @IBOutlet weak var lbTitle : UILabel!
    @IBOutlet weak var tfSearch : UITextField!
    @IBOutlet weak var viewContainer : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftMenu()
        showViewController(viewController: UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idListBoxWebViewVC"), title: "GÓC HỌC TẬP")
    }
    
    func showViewController(viewController : UIViewController, title : String) {
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
    
    func setLeftMenu(){
        let menuLeftNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        if (menuLeftNavigationController.topViewController is ActionMenuViewController) {
            (menuLeftNavigationController.topViewController as! ActionMenuViewController).parentView = self
        }
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
//        SideMenuManager.default.view
        SideMenuManager.default.menuWidth = self.view.frame.width * 0.8
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuShadowOpacity = 0.5
        SideMenuManager.default.menuFadeStatusBar = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sideMenuNavigationController = segue.destination as? ActionMenuViewController {
            sideMenuNavigationController.parentView = self
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

struct OptionToSave : Codable{
    var url : URL?
    var title : String
}

class CellOption : UITableViewCell {
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var content : UILabel!
    @IBOutlet weak var btnSave : UIButton!
}
