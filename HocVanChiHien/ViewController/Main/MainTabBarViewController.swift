//
//  MainTabBarViewController.swift
//  HocVanChiHien
//
//  Created by DC on 4/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController
import BubbleTransition

class MainTabBarViewController: UITabBarController, UIViewControllerTransitioningDelegate{
    
    var btn = CustomButton()
    var startPoint = CGPoint(x: 0, y: 0)
    let transition = BubbleTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.insertSubview(btn, belowSubview: self.tabBar)
        btn.clipsToBounds = true
        btn.backgroundColor = UIColor(hexString: "#ef0078")
        btn.layer.cornerRadius = 24
        btn.setImage(UIImage(named: "ic_player")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        btn.tintColor = UIColor.white
        btn.alpha = 0
        btn.isUserInteractionEnabled = false
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[button(48)]-32-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["button" : btn]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[button(48)]-\(self.tabBar.bounds.height + 32)-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: ["button" : btn]))
        btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPlayer)))
    }
    
    @objc func openPlayer(){
        startPoint = btn.center
        startAnim()
    }
    
    func startAnim(){
        let viewController = UIStoryboard(name: Constant.storyMain, bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.idAudioTab.vcPlayer) as! AudioPlayerViewController
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        self.present(viewController, animated: true, completion: nil)
    }
    
    func openPlayerFromPoint(position : CGPoint) {
        startPoint = position
        startAnim()
    }
    
//    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let controller = segue.destination
//        controller.transitioningDelegate = self
//        controller.modalPresentationStyle = .custom
//    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = startPoint
        transition.bubbleColor = UIColor(hexString: "#000000").withAlphaComponent(0.5)
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (btn.alpha == 0) {
            UIView.animate(withDuration: 0.2) {
                self.btn.alpha = 1
            }
        }
        btn.isUserInteractionEnabled = true
        transition.transitionMode = .dismiss
        transition.startingPoint = btn.center
        startPoint = btn.center
        transition.bubbleColor = UIColor(hexString: "#000000").withAlphaComponent(0.5)
        return transition
    }

}

class RAMBounceAnimation : RAMItemAnimation {
    
    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        playBounceAnimation(icon)
        textLabel.textColor = UIColor.white
    }
    
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        textLabel.textColor = defaultTextColor
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor = UIColor.yellow
    }
    
    func playBounceAnimation(_ icon : UIImageView) {
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(duration)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
    }
}
