//
//  WebViewController.swift
//  HocVanChiHien
//
//  Created by DC on 3/31/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import WebKit

class WebViewController : UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("\(message)")
    }
    
    var wkWebView : WKWebView!
    var userContentController: WKUserContentController!
    
    func initWKWebView(view : UIView) {
        //        let preferences = WKPreferences()
        //        preferences.javaScriptEnabled = true
        //        let contentController = WKUserContentController()
        //        contentController.add(self, name: "callbackHandler")
        //
        //        let config = WKWebViewConfiguration()
        //        config.websiteDataStore = WKWebsiteDataStore.default()
        //        config.userContentController = contentController
        
        //        wkWebView = WKWebView(frame: CGRect.zero, configuration: config)
        //        self.addSubview(wkWebView)
        userContentController = WKUserContentController()
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        wkWebView = WKWebView(frame: CGRect.zero, configuration: configuration)
        view.addSubview(wkWebView)
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[webview]-|",
                                                                   options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                                                                   metrics: nil,
                                                                   views: ["webview" : wkWebView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[webview]-|",
                                                                   options: NSLayoutConstraint.FormatOptions.alignAllCenterY,
                                                                   metrics: nil,
                                                                   views: ["webview" : wkWebView]))
        wkWebView.navigationDelegate = self
        wkWebView.isOpaque = false
    }
    
    func loadPage(urlString: String, partialContentQuerySelector selector: String) {
        userContentController.removeAllUserScripts()
        let userScript = WKUserScript(source: scriptWithDOMSelector(selector: selector),
                                      injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
                                      forMainFrameOnly: true)
        
        userContentController.addUserScript(userScript)
        
        let url = URL(string: urlString)!
        wkWebView.load(URLRequest(url: url))
    }
    
    func scriptWithDOMSelector(selector: String) -> String {
        let script =
            "var selectedElement = document.querySelector('\(selector)');" +
        "document.body.innerHTML = selectedElement.innerHTML;"
        return script
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinishLoadWebview()
    }
    
    func didFinishLoadWebview(){
        print("Function have not been override yet!")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Load Error")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Load Error : \(error)")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Load Start")
    }
}
