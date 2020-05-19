//
//  AudioManager.swift
//  SpaceRace
//
//  Created by Massimo Maddaluno on 21/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//
//
//  AudioManager.swift
//  SpaceRace
//


import Foundation
import AVFoundation


class AudioManager{
    
    static let shared = AudioManager()
    var audioPlayer: AVAudioPlayer?

    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "menuback", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
}

