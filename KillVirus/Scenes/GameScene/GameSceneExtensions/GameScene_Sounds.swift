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


extension GameScene
{
    func playSound(_ player:AVAudioPlayer?)->Void
    {
       
        guard let soundPlayer = player else {
           print("failed to play sound")
            
            return
            
            
        }
        if(soundPlayer.isPlaying)
        {
            soundPlayer.pause()
            soundPlayer.currentTime = 0.0
            soundPlayer.play()
            
        }
        else
        {
            soundPlayer.play()
        }
     
        
    }
    func loadAllSounds()->Void
    {
       loadBuzzerSound()
       loadTreasureSound()
       loadCoinSound()
    }
    private func loadSound(_ filename:String, player:inout AVAudioPlayer?, volume:Float)->Void
    {
        let path = Bundle.main.path(forResource:filename, ofType:nil) ?? ""
        let url = URL(fileURLWithPath: path)
        do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.volume = volume
                player?.prepareToPlay()        }
        catch
        {
                   print("loading sound failed")
        }
        do {
                    varsInitialValues.coinSoundEffect = try AVAudioPlayer(contentsOf: url)
        }
        catch
        {
                   print("loading sound failed")
        }
    }
    private func loadCoinSound()->Void
    {
        loadSound("Coin01.mp3", player: &gameVars.coinSoundEffect, volume: GameSceneConstants.coinSoundEffectVolume)
    }
    private func loadBuzzerSound()->Void
    {
        loadSound("Buzzer.mp3", player: &gameVars.buzzerSoundEffect , volume: GameSceneConstants.buzzerSoundEffectVolume)
           
    }
    private func loadTreasureSound()->Void
    {
        loadSound("Treasure.mp3", player: &gameVars.treasureSoundEffect , volume:1.0)
        
    }
    


}
