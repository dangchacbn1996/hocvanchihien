//
//  DemoWebViewViewController.swift
//  WeConnectIOS
//
//  Created by ChacND_HAV on 3/29/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class SavedListPosts: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView : UITableView!
    var listSaved = [OptionToSave]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if (UserDefaults.standard.object(forKey: "option_to_save") == nil) {
            listSaved = [OptionToSave]()
        } else {
            listSaved = UserDefaults.standard.object(forKey: "option_to_save") as! [OptionToSave]
        }
        print("ListSaved: \(listSaved.count)")
    }
    
//    func setLeftMenu(){
//        let menuLeftNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
//        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
//        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
//        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
//        SideMenuManager.default.menuWidth = self.view.frame.width * 0.8
//        SideMenuManager.default.menuPresentMode = .menuSlideIn
//        SideMenuManager.default.menuShadowOpacity = 0.5
//        SideMenuManager.default.menuFadeStatusBar = true
//    }
    
//    @IBAction func openMenu(){
//        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSaved.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSaved", for: indexPath) as! CellSaved
        cell.title.text = listSaved[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            return
        }
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailContentVC") as! DetailContentViewController
        viewController.data = Option(href : "", title : listSaved[indexPath.row].title, html : "", url : listSaved[indexPath.row].url)
        viewController.modalPresentationStyle = .overCurrentContext
        //        let file = "\(self.listOption[self.isSave].href.split(separator: "/").last ?? "").txt"
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func removeWord(_ cell : UIButton){
        
    }
}

class CellSaved : UITableViewCell {
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var btnRemove : UIButton!
}
