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
            gameVars.kachingEffect = try AVAudioPlayer(contentsOf: url)
            gameVars.kachingEffect?.prepareToPlay()
        } catch {
            // couldn't load file :(
        }
    }
    func playKachingSound()->Void
    {
        if (gameVars.kachingEffect?.isPlaying) != nil
        {
            if(gameVars.kachingEffect?.isPlaying ?? false)
            {
                gameVars.kachingEffect?.pause()
                gameVars.kachingEffect?.currentTime = 0.0
                gameVars.kachingEffect?.play()
            }
            else
            {
                 gameVars.kachingEffect?.play()
            }
           
        }
        
    }
}
