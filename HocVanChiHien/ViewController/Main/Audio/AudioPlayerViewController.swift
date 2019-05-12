//
//  AudioPlayerViewController.swift
//  HocVanChiHien
//
//  Created by ChacND_HAV on 4/12/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import FirebaseStorage
import AVKit
import BubbleTransition

class AudioPlayerViewController: UIViewController, AVAudioPlayerDelegate, AudioManagerDelegate{
    
    func reloadPlayerView() {
        if (AudioManager.instance.mediaPlayer != nil) {
            let current = AudioManager.instance.mediaPlayer.currentTime
            let duration = AudioManager.instance.mediaPlayer.duration.rounded()
            self.progressView.setProgress(Float(current/duration), animated: false)
            Loading.sharedInstance.dismiss()
            if (AudioManager.instance.mediaPlayer.isPlaying) {
                btnPlay.setImage(UIImage(named: "ic_pause"), for: UIControl.State.normal)
            } else {
                btnPlay.setImage(UIImage(named: "ic_play"), for: UIControl.State.normal)
            }
        }
        lbName.text = AudioManager.instance.nextSong.audioName ?? "Bài audio không tên!"
        lbContent.text = AudioManager.instance.nextSong.audioContent ?? ""
        imgAvatar.image = AudioManager.instance.avatar
    }
    
    @objc func updateProgressView() {
        if AudioManager.instance.mediaPlayer.isPlaying
        {
            let current = AudioManager.instance.mediaPlayer.currentTime
            let duration = AudioManager.instance.mediaPlayer.duration
            lbCurrent.text = "\(Int(current/60)):\(Int(current.truncatingRemainder(dividingBy: 60)))"
            progressView.setProgress(Float(current/duration), animated: true)
        }
    }
    
    func playAudio() {
        if (AudioManager.instance.mediaPlayer == nil) {
            Toast.shared.makeToast(string: "Audio chưa sẵn sàng! Quay lại sau 1 lúc nhé!", inView: self.view)
            reloadPlayerView()
            return
        }
        if (!AudioManager.instance.mediaPlayer.isPlaying) {
            AudioManager.instance.mediaPlayer.play()
            btnPlay.setImage(UIImage(named: "ic_pause"), for: UIControl.State.normal)
        } else {
            AudioManager.instance.mediaPlayer.pause()
            btnPlay.setImage(UIImage(named: "ic_play"), for: UIControl.State.normal)
        }
    }
    
    func startTimer() {
        let current = AudioManager.instance.mediaPlayer.currentTime
        let duration = AudioManager.instance.mediaPlayer.duration.rounded()
        Loading.sharedInstance.dismiss()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
        self.progressView.setProgress(Float(AudioManager.instance.mediaPlayer.currentTime/AudioManager.instance.mediaPlayer.duration), animated: false)
        self.lbDuration.text = "\(Int(duration/60)):\(Int(duration.truncatingRemainder(dividingBy: 60)))"
    }
    
    
//    var audioTarget : DataAudioFreeList = DataAudioFreeList()
    
//    var url : URL?
//    var mediaPlayer : AVAudioPlayer!
//    var image = UIImage(named: "Cho")
//    var data : Data!
    @IBOutlet weak var btnPlay : CustomButton!
    @IBOutlet weak var lbName : UILabel!
    @IBOutlet weak var lbContent : UILabel!
    @IBOutlet weak var imgAvatar : UIImageView!
    @IBOutlet weak var viewContainer : CustomView!
    @IBOutlet weak var lbCurrent : UILabel!
    @IBOutlet weak var lbDuration : UILabel!
    @IBOutlet weak var progressView : UIProgressView!
//    var duration : TimeInterval = 0
//    var current : TimeInterval = 0
    var interactiveTransition = BubbleInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        AudioManager.instance.reloadDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadPlayerView()
        Loading.sharedInstance.show(in: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioManager.instance.loadSong()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let locate = touches.first
        if (locate?.view != viewContainer) {
            goBack()
        }
    }
    
    func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playVideo(){
        playAudio()
    }
}
