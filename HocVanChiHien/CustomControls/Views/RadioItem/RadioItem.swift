//
//  RadioItem.swift
//  DerivativeIOS
//
//  Created by DC on 9/11/18.
//  Copyright © 2018 Ngo Dang Chac. All rights reserved.
//

import UIKit
import M13Checkbox

class RadioItem: UIView {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet var checkBoxView : UIView!
    var checkBox : M13Checkbox!
//    var heightLayout: NSLayoutConstraint!
//    var heightZero : NSLayoutConstraint!
//    var defaultFrame : CGRect!
    var isChecked = false
//    var size = DefaultValues.sizeFit(float: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    init(title : String) {
        super.init(frame: CGRect.zero)
        lbTitle.text = title
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func checked(){
        checkBox.setCheckState(.checked, animated: true)
    }
    
    func unchecked(){
        checkBox.setCheckState(.unchecked, animated: true)
    }
    
    func setupView(){
        Bundle.main.loadNibNamed("RadioItem", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lbTitle.textAlignment = .left
        lbTitle.numberOfLines = 0
        checkBox = M13Checkbox(frame: CGRect.zero)
        checkBox.boxType = .circle
        checkBox.markType = .radio
        checkBox.stateChangeAnimation = .expand(M13Checkbox.AnimationStyle.stroke)
        checkBoxView.addSubview(checkBox)
        checkBox.isUserInteractionEnabled = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.tintColor = Constant.Colors.colorBackgroundGrey
        checkBox.animationDuration = 0.3
        checkBox.topAnchor.constraint(equalTo: checkBoxView.topAnchor).isActive = true
        checkBox.bottomAnchor.constraint(equalTo: checkBoxView.bottomAnchor).isActive = true
        checkBox.leadingAnchor.constraint(equalTo: checkBoxView.leadingAnchor).isActive = true
        checkBox.trailingAnchor.constraint(equalTo: checkBoxView.trailingAnchor).isActive = true
    }
    
    func setContent(string : String) {
        lbTitle.text = string
    }
    
//    func resize(size : CGFloat){
//        self.size = DefaultValues.sizeFit(float: size)
//    }
    
    func setFont(size : CGFloat) {
        lbTitle.font = lbTitle.font.withSize(DefaultValues.sizeFit(float: size))
    }
    
}
