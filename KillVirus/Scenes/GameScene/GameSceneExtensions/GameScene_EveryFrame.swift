//
//  GameScene_EveryFrame.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 1/24/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene
{
       override func update(_ currentTime: TimeInterval)
       {
           moveBackgroundLayers()
           playerFollowFinger()
           spritesCovergeOnPlayer()
           skullsFollowPlayer()
           incrementBatCounters()
        
       }
       private func moveBackgroundLayers()->Void
       {
          var newPosition = gameVars.backLayer.position
          newPosition.y += gameVars.backgroundSpeed
          gameVars.backLayer.position.y = newPosition.y
          
       }
       private func playerFollowFinger()->Void
       {
           if(gameVars.screenTouched &&  !gameVars.bat.isHitByVirus)
           {
               if let touchLocation = gameVars.currentTouchLocation
               {
                   let deltaX = touchLocation.x - gameVars.bat.position.x
                   let deltaY = touchLocation.y - gameVars.bat.position.y
                   if(abs(deltaX) >= GameSceneConstants.batFollowFingerThreshold)
                   {
                       gameVars.bat.position.x += GameSceneConstants.batFollowFingerRatio * deltaX
                       if let capturedItem = gameVars.currentlyCapturedItem
                       {
                           capturedItem.position.x += GameSceneConstants.batFollowFingerRatio * deltaX
                       }
                       
                   }
                   if(abs(deltaY) >= GameSceneConstants.batFollowFingerThreshold)
                    {
                        
                        gameVars.bat.position.y += GameSceneConstants.batFollowFingerRatio * deltaY
                        if let capturedItem = gameVars.currentlyCapturedItem
                        {
                            capturedItem.position.y += GameSceneConstants.batFollowFingerRatio * deltaY
                        }
                                         
                       }
                   }
               
           }
       }

       private func spritesCovergeOnPlayer()->Void
       {
        gameVars.grid.spritesConvergeEveryFrame(gameVars.backLayer.position, gameVars.bat.position, GameSceneConstants.gemConvergeSpeed)
       }
       private func skullsFollowPlayer()->Void
       {
        gameVars.grid.spritesFollowPlayerEveryFrame(gameVars.backLayer.position, gameVars.bat.position, gameVars.skullFollowSpeed)
       }
       private func incrementBatCounters()->Void
       {
        gameVars.bat.incrementVirusHitCounter()
        gameVars.bat.incrementHealthPointsHealingCounter()
        gameVars.healthMeter.updateGreenBar(gameVars.bat.healthPoints, GameSceneConstants.batMaxHealthPoints)
        
       }

    
}
