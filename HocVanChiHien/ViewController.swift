//
//  DemoWebViewViewController.swift
//  WeConnectIOS
//
//  Created by ChacND_HAV on 3/29/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import WebKit

struct Option {
    var href : String
    var title : String
}

class ListOptionViewController: WebViewController, UITableViewDelegate, UITableViewDataSource{
    
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Load receive")
    }
    
    @IBOutlet weak var tableView : UITableView!
    var listOption = [Option]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        initWKWebView(view : UIView(frame: CGRect.zero))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadPage(urlString: "http://hocvanchihien.com/", partialContentQuerySelector: ".ListBoxNewsEvent")
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
                    var newOption = Option(href: "", title: "")
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
                    self.listOption.append(newOption)
                }
            }

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOption", for: indexPath) as! CellOption
        cell.title.text = listOption[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select: \(listOption[indexPath.row].href)")
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailContentVC") as! DetailContentViewController
        viewController.data = listOption[indexPath.row]
        self.present(viewController, animated: true, completion: nil)
    }
}

//extension ListOptionViewController : WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
//
//    func initWKWebView() {
//        //        let preferences = WKPreferences()
//        //        preferences.javaScriptEnabled = true
//        //        let contentController = WKUserContentController()
//        //        contentController.add(self, name: "callbackHandler")
//        //
//        //        let config = WKWebViewConfiguration()
//        //        config.websiteDataStore = WKWebsiteDataStore.default()
//        //        config.userContentController = contentController
//
//        //        wkWebView = WKWebView(frame: CGRect.zero, configuration: config)
//        //        self.addSubview(wkWebView)
//        userContentController = WKUserContentController()
//
//        let configuration = WKWebViewConfiguration()
//        configuration.userContentController = userContentController
//        wkWebView = WKWebView(frame: CGRect.zero, configuration: configuration)
//        self.view.addSubview(wkWebView)
//        //wkWebView.translatesAutoresizingMaskIntoConstraints = false
//        //        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H|-16-[wk]-16-|",
//        //                                                        options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
//        //                                                        metrics: nil,
//        //                                                        views: ["wk" : wkWebView]))
//        //        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V|-24-[wk]-16-|",
//        //                                                        options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
//        //                                                        metrics: nil,
//        //                                                        views: ["wk" : wkWebView]))
//        //        wkWebView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        //wkWebView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 56).isActive = true
//        //wkWebView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        //wkWebView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        //wkWebView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        wkWebView.navigationDelegate = self
//        wkWebView.isOpaque = false
//
//        //        wkWebView.configuration.userContentController = contentController
//        //        wkWebView.configuration.preferences = preferences
//    }
//
//    private func loadPage(urlString: String, partialContentQuerySelector selector: String) {
//        userContentController.removeAllUserScripts()
//        let userScript = WKUserScript(source: scriptWithDOMSelector(selector: selector),
//                                      injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
//                                      forMainFrameOnly: true)
//
//        userContentController.addUserScript(userScript)
//
//        let url = URL(string: urlString)!
//        wkWebView.load(URLRequest(url: url))
//    }
//
//    private func scriptWithDOMSelector(selector: String) -> String {
//        let script =
//            "var selectedElement = document.querySelector('\(selector)');" +
//        "document.body.innerHTML = selectedElement.innerHTML;"
//        return script
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent').length;") {(result, error) in
//            guard error == nil else {
//                print("HTMLErr: \(error!)")
//                return
//            }
//            print("HTMLEvaC: \(String(describing: result!))")
//            if let amount = Int(String(describing: result!)) {
//                for index in 0..<amount {
//                    //Đọc góc học tập
//                    var newOption = Option(href: "", title: "")
////                    webView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent')[\(index)].children[0].children[2].children[1].children[0].title;", completionHandler: { (result, error) in
////                        newOption.href = result ?? ""
////                        })
//                    webView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent')[\(index)].children[0].children[\(JSContruct.BoxNewsEvent.EventTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4ContainTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4SubA)].href;", completionHandler: { (result, error) in
//                        self.listOption[index].href = "\(result ?? "")"
//                        if (index == amount - 1) {
//                            self.tableView.reloadData()
//                        }
//                    })
//                    webView.evaluateJavaScript("document.getElementsByClassName('BoxNewsEvent')[\(index)].children[0].children[\(JSContruct.BoxNewsEvent.EventTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4ContainTitle)].children[\(JSContruct.BoxNewsEvent.EventTitleSub.h4SubA)].title;", completionHandler: { (result, error) in
//                        self.listOption[index].title = "\(result ?? "")"
//                        if (index == amount - 1) {
//                            self.tableView.reloadData()
//                        }
//                    })
//                    self.listOption.append(newOption)
//                }
//            }
//
//        }
//    }
//
//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        print("Load Error")
//    }
//
//    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        print("Load Error : \(error)")
//    }
//
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        print("Load Start")
//    }
//}

class CellOption : UITableViewCell {
    @IBOutlet weak var title : UILabel!
}
