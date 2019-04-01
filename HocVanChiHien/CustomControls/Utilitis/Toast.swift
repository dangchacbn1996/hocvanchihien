//
//  Toast.swift
//  DerivativeIOS
//
//  Created by DC on 12/4/18.
//  Copyright © 2018 Ngo Dang Chac. All rights reserved.
//

import Foundation
import Toast_Swift

class Toast {
    public static let shared = Toast()
    
    var toastStyle : ToastStyle!
    
    private init(){
        toastStyle = ToastStyle()
//        toastStyle.verticalPadding = 30
        toastStyle.backgroundColor = UIColor(hexString: "00ba6d").withAlphaComponent(0.85)
        ToastManager.shared.style = toastStyle
    }
    
    public func makeToast(string : String, inView : UIView) {
//        inView.makeToast(string)
        inView.makeToast(string, duration: 5, position: .bottom, title: "", image: nil, style: toastStyle, completion: nil)
//        inView.makeToast(string, duration: 2, point: CGPoint(x: 0.5, y: 0.5), title: nil, image: nil, style: toastStyle, completion: nil)
        
    }
    
//    public func makeToast(string : String, inview : UIView, pos : CGFloat) {
//        inview.makeToast(string,
//                         point: <#T##CGPoint#>,
//                         title: <#T##String?#>,
//                         image: nil,
//                         completion: nil)
//        inview.makeToast
//    }
    
    public func makeToastNotification(mess : String, inView : UIView) {
        inView.makeToast(mess, duration: 3, position: .top, title: "", image: nil, style: toastStyle, completion: nil)
    }
}
