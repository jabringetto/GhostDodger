//
//  GameScene_Sounds.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 1/24/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

extension GameScene {
    func loadAllSounds() {
        // The actual loading is now handled by setupAudioEngine()
        // Just start the background music
        playGameSceneBackgroundMusic()
    }
    
    internal func loadSound(_ filename: String, player: inout AVAudioPlayer?, volume: Float) {
        if let existingPlayer = gameSoundPlayers[filename] {
            player = existingPlayer
        }
    }
    
    func playGameSceneBackgroundMusic() {
        gameVars.backgroundMusicPlayer?.numberOfLoops = -1
        gameVars.backgroundMusicPlayer?.play()
    }
    
    func playSound(_ player: AVAudioPlayer?) {
        guard let soundPlayer = player else {
            print("failed to play sound")
            return
        }
        
        if soundPlayer.isPlaying {
            soundPlayer.pause()
            soundPlayer.currentTime = 0.0
            soundPlayer.play()
        } else {
            soundPlayer.play()
        }
    }
}
