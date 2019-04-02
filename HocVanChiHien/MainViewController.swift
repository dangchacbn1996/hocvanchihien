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

struct Option {
    var href : String
    var title : String
    var content : String
}

class ListOptionViewController: WebViewController, UITableViewDelegate, UITableViewDataSource{
    
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Load receive")
    }
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var lbTitle : UILabel!
    var listOption = [Option]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        lbTitle.text = "GÓC HỌC TẬP - GÓC HOẠT ĐỘNG"
        initWKWebView(view : UIView(frame: CGRect.zero))
        setLeftMenu()
    }
    
    func setLeftMenu(){
        let menuLeftNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.default.menuWidth = self.view.frame.width * 0.8
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuShadowOpacity = 0.5
//        SideMenuManager.default.menuShadowColor = UIColor.black
        SideMenuManager.default.menuFadeStatusBar = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadPage(urlString: "http://hocvanchihien.com/", partialContentQuerySelector: ".ListBoxNewsEvent")
    }
    
    @IBAction func openMenu(){
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didFinishLoadWebview(){
        wkWebView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent').length;") {(result, error) in
            guard error == nil else {
                print("HTMLErr: \(error!)")
                return
            }
            print("HTMLEvaC: \(String(describing: result!))")
            if let amount = Int(String(describing: result!)) {
                for index in 0..<amount {
                    //Đọc góc học tập
                    var newOption = Option(href: "", title: "", content : "")
                    self.wkWebView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent')[\(index)].children[0].children[\(JSContruct.BoxNewsEvent.EventTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4ContainTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4SubA)].href;", completionHandler: { (result, error) in
                        self.listOption[index].href = "\(result ?? "")"
                        if (index == amount - 1) {
                            self.tableView.reloadData()
                        }
                    })
                    self.wkWebView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent')[\(index)].children[0].children[\(JSContruct.BoxNewsEvent.EventTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4ContainTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4SubA)].title;", completionHandler: { (result, error) in
                        self.listOption[index].title = "\(result ?? "")"
                        if (index == amount - 1) {
                            self.tableView.reloadData()
                        }
                    })
                    self.wkWebView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent')[\(index)].children[1].children[0].innerText;", completionHandler: { (result, error) in
                        self.listOption[index].content = "\(result ?? "")"
                        if (index == amount - 1) {
                            self.tableView.reloadData()
                        }
                    })
                    self.listOption.append(newOption)
                }
            }

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOption.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellImage", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOption", for: indexPath) as! CellOption
        cell.title.text = listOption[indexPath.row - 1].title
        cell.selectionStyle = .none
        cell.content.text = listOption[indexPath.row - 1].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            return
        }
        print("Select: \(listOption[indexPath.row].href)")
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailContentVC") as! DetailContentViewController
        viewController.data = listOption[indexPath.row + 1]
        self.present(viewController, animated: true, completion: nil)
    }
}

class CellOption : UITableViewCell {
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var content : UILabel!
}
