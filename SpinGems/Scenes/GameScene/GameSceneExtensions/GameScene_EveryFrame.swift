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
           batFollowFinger()
           spritesCovergeOnBat()
           skullsFollowBat()
       }
       private func moveBackgroundLayers()->Void
       {
          var newPosition = GameSceneConstants.backLayer.position
          newPosition.y += gameVars.backgroundSpeed
          GameSceneConstants.backLayer.position.y = newPosition.y
          
       }
       private func batFollowFinger()->Void
       {
           if(gameVars.screenTouched)
           {
               if let touchLocation = gameVars.currentTouchLocation
               {
                   let deltaX = touchLocation.x - GameSceneConstants.bat.position.x
                   let deltaY = touchLocation.y - GameSceneConstants.bat.position.y
                   if(abs(deltaX) >= GameSceneConstants.batFollowFingerThreshold)
                   {
                       GameSceneConstants.bat.position.x += GameSceneConstants.batFollowFingerRatio * deltaX
                       if let capturedItem = gameVars.currentlyCapturedItem
                       {
                           capturedItem.position.x += GameSceneConstants.batFollowFingerRatio * deltaX
                       }
                       
                   }
                   if(abs(deltaY) >= GameSceneConstants.batFollowFingerThreshold)
                    {
                        
                        GameSceneConstants.bat.position.y += GameSceneConstants.batFollowFingerRatio * deltaY
                        if let capturedItem = gameVars.currentlyCapturedItem
                        {
                            capturedItem.position.y += GameSceneConstants.batFollowFingerRatio * deltaY
                        }
                                         
                       }
                   }
               
           }
       }

       private func spritesCovergeOnBat()->Void
       {
        gameVars.grid.spritesConvergeEveryFrame(GameSceneConstants.backLayer.position, GameSceneConstants.bat.position, GameSceneConstants.gemConvergeSpeed)
       }
       private func skullsFollowBat()->Void
       {
        gameVars.grid.skullsFollowPlayerEveryFrame(GameSceneConstants.backLayer.position, GameSceneConstants.bat.position, gameVars.skullFollowSpeed)
       }

    
}
