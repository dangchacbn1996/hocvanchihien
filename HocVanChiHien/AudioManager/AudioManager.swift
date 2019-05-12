//
//  AudioManager.swift
//  HocVanChiHien
//
//  Created by ChacND_HAV on 4/12/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import AVKit

@objc protocol AudioManagerDelegate {
    @objc func updateProgressView()
    func playAudio()
    func startTimer()
    func reloadPlayerView()
}

class AudioManager{
    public static let instance = AudioManager()
    var audioTarget : DataAudioFreeList!
    var nextSong : DataAudioFreeList!
    var mediaPlayer : AVAudioPlayer!
    var image = UIImage(named: "Cho")
    var data : Data!
    var duration : TimeInterval = 0
    var current : TimeInterval = 0
    var loadDone = false
    var delegate : AVAudioPlayerDelegate!
    var reloadDelegate : AudioManagerDelegate!
    var avatar = UIImage(named: "Cho")
    
    private init(){
    }

    func loadSong(){
        if (self.audioTarget != nil) {
            if (self.audioTarget.audioUrl != nil) {
                if (nextSong.audioUrl == self.audioTarget.audioUrl) {
                    reloadDelegate.reloadPlayerView()
                    reloadDelegate.startTimer()
                    return
                }
            }
        }
        self.audioTarget = nextSong
        if (audioTarget.audioUrl != nil) {
            do {
                if let url = URL(string: audioTarget.audioUrl!) {
                    self.data = try Data(contentsOf: url)
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
                    try AVAudioSession.sharedInstance().setActive(true)
                    self.mediaPlayer = try AVAudioPlayer(data: self.data, fileTypeHint: AVFileType.mp3.rawValue)
                    self.mediaPlayer.delegate = self.delegate
                    reloadDelegate.startTimer()
                    reloadDelegate.playAudio()
                }
                
            } catch let error {
//                Loading.sharedInstance.dismiss()
                print("Firebase:Pl \(error)")
                Loading.sharedInstance.dismiss()
            }
        }
    }
    
    func playVideo(){
        reloadDelegate.playAudio()
//        btnPlay.setImage(mediaPlayer.isPlaying ? UIImage(named: "ic_play") : UIImage(named: "ic_pause"), for: UIControl.State.normal)
//        if (!mediaPlayer.isPlaying) {
//            mediaPlayer.play()
//            btnPlay.setImage(UIImage(named: "ic_pause"), for: UIControl.State.normal)
//        } else {
//            mediaPlayer.pause()
//            btnPlay.setImage(UIImage(named: "ic_play"), for: UIControl.State.normal)
//        }
    }
    
}
