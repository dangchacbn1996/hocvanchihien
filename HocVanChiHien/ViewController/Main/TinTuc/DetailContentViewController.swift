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
    @IBOutlet weak var bottom: NSLayoutConstraint!
    var bottomSpace : CGFloat = 0
    
    override func viewDidLoad() {
        initWKWebView(view: webViewContainer)
        loadPage(urlString: data?.href ?? "", partialContentQuerySelector: ".detailContent")
        if (bottomSpace != 0) {
            bottom.isActive = false
            bottom = self.viewContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -bottomSpace - 32)
            bottom.isActive = true
        }
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
