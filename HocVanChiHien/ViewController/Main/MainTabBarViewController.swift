//
//  MainTabBarViewController.swift
//  HocVanChiHien
//
//  Created by DC on 4/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
//import RAMAnimatedTabBarController
import BubbleTransition
import AVKit

class MainTabBarViewController: UITabBarController, UIViewControllerTransitioningDelegate, AVAudioPlayerDelegate{
    
    var btn : CustomButton!
    var origin : CGPoint!
    var startPoint = CGPoint(x: 0, y: 0)
    let transition = BubbleTransition()
    var viewPlayer : AudioPlayerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        AudioManager.instance.delegate = self
        origin = CGPoint(x: self.view.frame.width - 80, y: self.view.frame.height - (self.tabBar.bounds.height + 80))
        print("Origin: \(origin)")
        btn = CustomButton(frame: CGRect(origin: origin, size: CGSize(width: 48, height: 48)))
        self.view.insertSubview(btn, belowSubview: self.tabBar)
        btn.clipsToBounds = true
        btn.backgroundColor = UIColor(hexString: "#ef0078")
        btn.layer.cornerRadius = 24
        btn.setImage(UIImage(named: "ic_player")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        btn.tintColor = UIColor.white
        btn.alpha = 0
        btn.isUserInteractionEnabled = false
        btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPlayer)))
        btn.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragButton(panGesture:))))
        
        viewPlayer = UIStoryboard(name: Constant.storyMain, bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.idAudioTab.vcPlayer) as! AudioPlayerViewController
        viewPlayer.modalPresentationStyle = .overCurrentContext
        viewPlayer.transitioningDelegate = self
        viewPlayer.modalPresentationStyle = .custom
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.btn.isUserInteractionEnabled = false
        viewPlayer.dismiss(animated: true, completion: nil)
        UIView.animate(withDuration: 0.2) {
            self.btn.alpha = 0
        }
    }
    
    @objc func dragButton(panGesture recognizer: UIPanGestureRecognizer){
        var newPosition = recognizer.location(in: self.view)
        if (newPosition.x < btn.frame.width / 2 + 4) {
            newPosition.x = btn.frame.width / 2 + 4
        }
        if (newPosition.x > self.view.frame.width - btn.frame.width / 2 - 4) {
            newPosition.x = self.view.frame.width - btn.frame.width / 2 - 4
        }
        if (newPosition.y < btn.frame.height / 2 + 4 + UIApplication.shared.statusBarFrame.height) {
            newPosition.y = btn.frame.height / 2 + 4 + UIApplication.shared.statusBarFrame.height
        }
        if (newPosition.y > self.view.frame.height - (self.tabBar.bounds.height + btn.frame.height / 2 + 4)) {
            newPosition.y = self.view.frame.height - (self.tabBar.bounds.height + btn.frame.height / 2 + 4)
        }
        if recognizer.state == .began {
            btn.center = btn.center
        } else if recognizer.state == .ended || recognizer.state == .failed || recognizer.state == .cancelled {
            if (newPosition.x < self.view.frame.width / 2) {
                newPosition.x = btn.frame.width / 2 + 4
            } else {
                newPosition.x = self.view.frame.width - btn.frame.width / 2 - 4
            }
            UIView.animate(withDuration: 0.2) {
                self.btn.center = newPosition
            }
        } else {
            btn.center = newPosition // set button to where finger is
        }
    }
    
    @objc func openPlayer(){
        startPoint = btn.center
        UIView.animate(withDuration: 0.2) {
            self.btn.alpha = 1
        }
        startAnim()
    }
    
    func startAnim(){
        self.present(viewPlayer, animated: true, completion: nil)
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

//class RAMBounceAnimation : RAMItemAnimation {

//    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
//        playBounceAnimation(icon)
//        textLabel.textColor = UIColor.white
//    }

//    
//    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
//        textLabel.textColor = defaultTextColor
//    }
//    
//    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
//        textLabel.textColor = UIColor.yellow
//    }
//    
//    func playBounceAnimation(_ icon : UIImageView) {
//        
//        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
//        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
//        bounceAnimation.duration = TimeInterval(duration)
//        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic

//        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
//    }
//}
