//
//  DetailContentViewController.swift
//  HocVanChiHien
//
//  Created by DC on 3/31/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import WebKit

class DetailContentViewController : WebViewController {
    
//    var data = Option(href : "",title : "", content : "")
    var data : Option!
    @IBOutlet weak var webViewContainer : UIView!
    @IBOutlet weak var viewContainer : UIView!
    
    override func viewDidLoad() {
        initWKWebView(view: webViewContainer)
//        if (data.url == nil) {
//            Toast.shared.makeToastNotification(mess: "Bài viết chưa được lưu lại. Vui lòng bật mạng lên nhé!", inView: self.view)
//        } else {
//            let fileURL = data.url ?? URL(string: "")!
//            do {
//                let html = try String(contentsOf: fileURL, encoding: .utf8)
//                print("Read back text: \(html)")
//                wkWebView.loadHTMLString(html , baseURL: nil)
//            }
//            catch {
//                print("failed with error: \(error)")
//            }
//        }
        loadPage(urlString: data?.href ?? "", partialContentQuerySelector: ".detailContent")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let locate = touches.first
        if (locate?.view != viewContainer) {
            goBack()
        }
    }
    
    override func didFinishLoadWebview() {
        
        let javascriptStyle = "var css = '*{-webkit-touch-callout:none;-webkit-user-select:none}'; var head = document.head || document.getElementsByTagName('head')[0]; var style = document.createElement('style'); style.type = 'text/css'; style.appendChild(document.createTextNode(css)); head.appendChild(style);"
        wkWebView.evaluateJavaScript(javascriptStyle, completionHandler: nil)
    }
    
    @IBAction func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
}
