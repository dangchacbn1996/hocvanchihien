//
//  RoundedView.swift
//  AppDatXe
//
//  Created by DC on 3/8/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

@IBDesignable
class CustomImageView: UIImageView {
    var _cornerRadius: CGFloat = 0.0
    var _cornerUseMulti: Bool = false
    var _cornerUseScreen: Bool = false
    var _circleView: Bool = false
    var _borderWidth: CGFloat = 0.0
    var _borderColor: UIColor = UIColor.clear
    var _dropShadow: CGFloat = 0
    var _imageIcon = UIImage()
    
    @IBInspectable
    var icon: UIImage {
        set (newValue) {
            self._imageIcon = newValue
            self.image = _imageIcon.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        } get {
            return _imageIcon
        }
    }
    
    @IBInspectable
    var dropShadow: CGFloat {
        set (newValue) {
            _dropShadow = newValue
            self.layer.shadowColor = UIColor.gray.cgColor
            self.layer.shadowOpacity = _dropShadow > 0 ? 1 : 0
            self.layer.shadowOffset = CGSize.zero
            self.layer.shadowRadius = _dropShadow
        } get {
            return _dropShadow
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set (newValue) {
            _cornerRadius = newValue
            if (!_cornerUseMulti) {
                layer.cornerRadius = _cornerRadius
            }
        } get {
            return _cornerRadius
        }
    }
    
    @IBInspectable
    var cornerUseMulti: Bool {
        set (newValue) {
            _cornerUseMulti = newValue
            if (_cornerUseMulti && !circleView && !_cornerUseScreen) {
                layer.cornerRadius = self.frame.width < self.frame.height ? self.frame.width / 10 : self.frame.height / 10
            }
        } get {
            return _cornerUseMulti
        }
    }
    
    @IBInspectable
    var cornerUseScreen: Bool {
        set (newValue) {
            _cornerUseScreen = newValue
            if (_cornerUseScreen && !circleView) {
                layer.cornerRadius = UIScreen.main.bounds.width / 40
            }
        } get {
            return _cornerUseScreen
        }
    }
    
    
    @IBInspectable
    var circleView: Bool {
        set (newValue) {
            if (newValue) {
                layer.cornerRadius = self.frame.height / 2
                self.clipsToBounds = true
            }
        } get {
            return _circleView
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        set (newValue) {
            _borderWidth = newValue
            layer.borderWidth = newValue
        }
        get {
            return _borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        set (newValue) {
            _borderColor = newValue
            layer.borderColor = _borderColor.cgColor
        } get {
            return _borderColor
        }
    }
    
}
