//
//  CornerButton.swift
//  AppDatXe
//
//  Created by DC on 3/7/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

@IBDesignable
class CustomImageView: UIImageView {
        var _cornerRadius: CGFloat = 0.0
    //    var _cornerUseMulti: Bool = false
    //    var _cornerUseScreen: Bool = false
    //    var _circleView: Bool = false
    //    var _borderWidth: CGFloat = 0.0
    //    var _borderColor: UIColor = UIColor.clear
    var _imageMulti: CGFloat = 1.0
    var _image: UIImage = UIImage()
    
        @IBInspectable
        var cornerRadius: CGFloat {
            set (newValue) {
                _cornerRadius = newValue
//                if (!_cornerUseMulti) {
                    layer.cornerRadius = _cornerRadius
//                }
            } get {
                return _cornerRadius
            }
        }
    var _dropShadow: CGFloat = 0
    
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
    var iconImage: UIImage {
        set (newValue) {
            _image = newValue
            self.image = _image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        } get {
            return _image
        }
    }
    
    @IBInspectable
    var imageMulti: CGFloat {
        set (newValue) {
            _imageMulti = newValue
            //            self.alignmentRectInsets = UIEdgeInsets(top: self.frame.height * (1 - _imageMulti) / 2,
            //                                                left: self.frame.width * (1 - _imageMulti) / 2,
            //                                                bottom: self.frame.height * (1 - _imageMulti) / 2,
            //                                                right: self.frame.width * (1 - _imageMulti) / 2)
        } get {
            return _imageMulti
        }
    }
    //
    //    @IBInspectable
    //    var cornerUseMulti: Bool {
    //        set (newValue) {
    //            _cornerUseMulti = newValue
    //            if (_cornerUseMulti && !circleView && !_cornerUseScreen) {
    //                layer.cornerRadius = self.frame.width < self.frame.height ? self.frame.width / 10 : self.frame.height / 10
    //            }
    //        } get {
    //            return _cornerUseMulti
    //        }
    //    }
    //
    //    @IBInspectable
    //    var cornerUseScreen: Bool {
    //        set (newValue) {
    //            _cornerUseScreen = newValue
    //            if (_cornerUseScreen && !circleView) {
    //                layer.cornerRadius = UIScreen.main.bounds.width / 40
    //            }
    //        } get {
    //            return _cornerUseScreen
    //        }
    //    }
    //
    //
    //    @IBInspectable
    //    var circleView: Bool {
    //        set (newValue) {
    //            if (newValue) {
    //                layer.cornerRadius = self.frame.height / 2
    //            }
    //        } get {
    //            return _circleView
    //        }
    //    }
    //
    //    @IBInspectable
    //    var borderWidth: CGFloat {
    //        set (newValue) {
    //            _borderWidth = newValue
    //            layer.borderWidth = newValue
    //        }
    //        get {
    //            return _borderWidth
    //        }
    //    }
    //
    //    @IBInspectable
    //    var borderColor: UIColor {
    //        set (newValue) {
    //            _borderColor = newValue
    //            layer.borderColor = _borderColor.cgColor
    //        } get {
    //            return _borderColor
    //        }
    //    }
    
}
