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
        if (self.children.count > 0) {
            self.children.forEach { (vc) in
                vc.removeFromParent()
            }
        }
        addChild(viewController)
        self.viewContainer.addSubview(viewController.view)
        viewController.view.frame = viewContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    func setLeftMenu(){
        let menuLeftNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
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

struct OptionToSave {
    var url : URL?
    var title : String
}

class CellOption : UITableViewCell {
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var content : UILabel!
    @IBOutlet weak var btnSave : UIButton!
}
