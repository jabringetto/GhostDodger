//
//  GameScene_Sounds.swift
//  SpinGems
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
        guard let soundPlayer = player else {return}
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
    func loadSounds()->Void
    {
       loadBuzzerSound()
       loadTreasureSound()
    }
    private func loadBuzzerSound()->Void
    {
        let path = Bundle.main.path(forResource:"Buzzer.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            do {
                     gameVars.buzzerSoundEffect = try AVAudioPlayer(contentsOf: url)
                     gameVars.buzzerSoundEffect?.volume = 0.03
                     gameVars.buzzerSoundEffect?.prepareToPlay()
            }
            catch
            {
                    // couldn't load file :(
            }
    }
    private func loadTreasureSound()->Void
    {
        let path = Bundle.main.path(forResource:"Treasure.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
                 gameVars.treasureSoundEffect = try AVAudioPlayer(contentsOf: url)
                 gameVars.treasureSoundEffect?.prepareToPlay()
        }
        catch
        {
                 // couldn't load file :(
        }
    }
    


}
