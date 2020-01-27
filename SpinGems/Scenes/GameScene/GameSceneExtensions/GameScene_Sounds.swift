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
    
    func loadSounds()->Void
    {
        let path = Bundle.main.path(forResource:"Red.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            gameVars.gemSoundEffect = try AVAudioPlayer(contentsOf: url)
            gameVars.gemSoundEffect?.prepareToPlay()
        } catch {
            // couldn't load file :(
        }
    }
    func playKachingSound()->Void
    {
        if (gameVars.gemSoundEffect?.isPlaying) != nil
        {
            if(gameVars.gemSoundEffect?.isPlaying ?? false)
            {
                gameVars.gemSoundEffect?.pause()
                gameVars.gemSoundEffect?.currentTime = 0.0
                gameVars.gemSoundEffect?.play()
            }
            else
            {
                 gameVars.gemSoundEffect?.play()
            }
           
        }
        
    }
}
