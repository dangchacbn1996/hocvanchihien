//
//  ListWebViewElementsViewController.swift
//  HocVanChiHien
//
//  Created by DC on 4/2/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SideMenu
import WebKit

class ListWebViewElementsViewController: WebViewController, UITableViewDelegate, UITableViewDataSource{
    
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Load receive")
    }
    
    @IBOutlet weak var tableView : UITableView!
    var listOption = [Option]()
    var target = OptionToSave(url : URL(string: "http://hocvanchihien.com/"), title : "Trang chủ")
    var isSave = -1
    var index = 0
    var page = 0
    var listSaved = [OptionToSave]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        target = Constant.AddressInfo.getWebInfo(type: index, page: page)
        initWKWebView(view : UIView(frame: CGRect.zero))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadPage(urlString: target.url?.absoluteString ?? "http://hocvanchihien.com/", partialContentQuerySelector: ".NewsEvent")
    }
    
    @IBAction func openMenu(){
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    
    override func didFinishLoadWebview(){
        if (isSave != -1) {
            wkWebView.evaluateJavaScript("document.documentElement.outerHTML.toString();") {(result, wkError) in
                print("HTMLErr: \(wkError)")
                guard wkError == nil else {
                    print("HTMLErr: \(wkError!)")
                    Loading.sharedInstance.dismiss()
                    return
                }
                
                let file = "\(self.listOption[self.isSave].href.split(separator: "/").last ?? "").txt"
                //this is the file. we will write to and read from it
                
                let text = "\(String(describing: result ?? ""))"
                //                UserDefaults.standard.set
                
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    
                    let fileURL = dir.appendingPathComponent(file)
                    //writing
                    do {
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                        self.listOption[self.isSave].url = fileURL
                        var listSaved = ListSaved()
                        if let savedList = UserDefaults.standard.object(forKey: "list_post_saved") as? Data {
                            let decoder = JSONDecoder()
                            if let loadedList : ListSaved = try? decoder.decode(ListSaved.self, from: savedList) {
                                listSaved = loadedList
                            }
                        }
                        listSaved.listSaved.append(OptionToSave(url : fileURL, title : self.listOption[self.isSave].title))
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(listSaved) {
                            let defaults = UserDefaults.standard
                            defaults.set(encoded, forKey: "list_post_saved")
                        }
                    }
                    catch {/* error handling here */}
                }
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
            let lastIndex = self.listOption.count
            if let amount = Int(String(describing: result!)) {
                for index in 0..<amount {
                    var newOption = Option(href: "", title: "", html: "", url: nil)
                    self.wkWebView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent')[\(index)].children[0].children[\(JSContruct.BoxNewsEvent.EventTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4ContainTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4SubA)].href;", completionHandler: { (result, error) in
                        self.listOption[lastIndex + index].href = "\(result ?? "")"
                        if (index == amount - 1) {
                            self.tableView.reloadData()
                        }
                    })
                    self.wkWebView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent')[\(index)].children[0].children[\(JSContruct.BoxNewsEvent.EventTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4ContainTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4SubA)].title;", completionHandler: { (result, error) in
                        self.listOption[lastIndex + index].title = "\(result ?? "")"
                        if (index == amount - 1) {
                            self.tableView.reloadData()
                        }
                    })
                    self.wkWebView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent')[\(index)]\(JSContruct.BoxNewsEvent.getContent)", completionHandler: { (result, error) in
                        if error != nil {
                            self.wkWebView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent')[\(index)]\(JSContruct.BoxNewsEvent.getHomePageContent)", completionHandler: { (result, error) in
                                if error != nil {
                                    self.listOption[lastIndex + index].html = ""
                                } else {
                                    self.listOption[lastIndex + index].html = "\(result ?? "")"
                                }
                                if (index == amount - 1) {
                                    self.tableView.reloadData()
                                }
                            })
                        } else {
                            self.listOption[lastIndex + index].html = "\(result ?? "")"
                            if (index == amount - 1) {
                                self.tableView.reloadData()
                            }
                        }
                    })
                    self.listOption.append(newOption)
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        page += 1
        target = Constant.AddressInfo.getWebInfo(type: index, page: page)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == listOption.count - 1) {
            page += 1
            target = Constant.AddressInfo.getWebInfo(type: index, page: page)
            loadPage(urlString: target.url?.absoluteString ?? "http://hocvanchihien.com/", partialContentQuerySelector: ".NewsEvent")
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
