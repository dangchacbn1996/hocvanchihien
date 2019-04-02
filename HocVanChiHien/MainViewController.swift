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
    var html : String
    var url : URL?
}

class ListOptionViewController: WebViewController, UITableViewDelegate, UITableViewDataSource{
    
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Load receive")
    }
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var lbTitle : UILabel!
    var listOption = [Option]()
    var isSave = -1
    
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
        if (isSave != -1) {
            wkWebView.evaluateJavaScript("document.documentElement.outerHTML.toString();") {(result, wkError) in
                guard wkError == nil else {
                    print("HTMLErr: \(wkError!)")
                    Loading.sharedInstance.dismiss()
                    return
                }
                let file = "\(self.listOption[self.isSave].href).txt" //this is the file. we will write to and read from it
                
                let text = "\(String(describing: result ?? ""))"
                
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    
                    let fileURL = dir.appendingPathComponent(file)
                    self.listOption[self.isSave].url = fileURL
                    //writing
                    do {
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                    }
                    catch {/* error handling here */}
                    
                    //reading
                    
                }
//                let fileName = "\(self.listOption[self.isSave].href)"
//                let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//
//                let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
//                  self.listOption[self.isSave].url = fileURL
//
//                let text = "\(String(describing: result ?? ""))"
//                do {
//                    try text.write(to: fileURL, atomically: true, encoding: .utf8)
//                } catch {
//                    print("failed with error: \(error)")
//                }
                
//                UserDefaults.standard.set("\(String(describing: result ?? ""))", forKey: self.detailContentPage.href)
//                print("CheckSave: \(self.detailContentPage.href)")
                self.isSave = -1
                Loading.sharedInstance.dismiss()
            }
            return
        }
        wkWebView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent').length;") {(result, error) in
            guard error == nil else {
                print("HTMLErr: \(error!)")
                return
            }
            print("HTMLEvaC: \(String(describing: result!))")
            if let amount = Int(String(describing: result!)) {
                for index in 0..<amount {
                    //Đọc góc học tập
                    var newOption = Option(href: "", title: "", html: "", url: nil)
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
                        self.listOption[index].html = "\(result ?? "")"
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
        cell.content.text = listOption[indexPath.row - 1].html
        cell.btnSave.tag = indexPath.row - 1
        cell.btnSave.addTarget(self, action: #selector(saveWord(_:)), for: UIControl.Event.touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            return
        }
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailContentVC") as! DetailContentViewController
        viewController.data = listOption[indexPath.row - 1]
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func saveWord(_ cell : UIButton){
        isSave = cell.tag
        Loading.sharedInstance.show(in: tableView)
//        detailContentPage = Option(href: listOption[cell.tag].href,
//                                   title: listOption[cell.tag].title,
//                                   html: listOption[cell.tag].html,
//                                   url: listOption[cell.tag].url)
        loadPage(urlString: listOption[cell.tag].href, partialContentQuerySelector: ".detailContent")
    }
}

class CellOption : UITableViewCell {
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var content : UILabel!
    @IBOutlet weak var btnSave : UIButton!
}
