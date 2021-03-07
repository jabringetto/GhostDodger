//
//  EnterScene_Sounds.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 2/14/21.
//  Copyright © 2021 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

extension EnterScene
{

    
    func loadEnterSceneBackgroundMusic()->Void
    {
        loadSound("VirusDodger_EnterScene.mp3", player: &sceneVars.enterMusicPlayer, volume: 0.5)
    }
    func playEnterSceneBackgroundMusic()->Void
    {
        sceneVars.enterMusicPlayer?.numberOfLoops = -1
        sceneVars.enterMusicPlayer?.play()
    }
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

    }
    
    
    
}
