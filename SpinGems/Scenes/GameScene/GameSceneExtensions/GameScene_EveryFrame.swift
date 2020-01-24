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
           GameSceneConstants.backLayer.position = newPosition
           GameSceneConstants.frontLayer.position.y = 2 * GameSceneConstants.backLayer.position.y
          
       }
       private func batFollowFinger()->Void
       {
           if(gameVars.screenTouched)
           {
               if let touchLocation = gameVars.currentTouchLocation
               {
                   let delta = touchLocation.x - GameSceneConstants.bat.position.x
                   if(abs(delta) >= GameSceneConstants.batFollowFingerThreshold)
                   {
                    GameSceneConstants.bat.position.x += GameSceneConstants.batFollowFingerRatio * delta
                       if let capturedItem = gameVars.currentlyCapturedItem
                       {
                           capturedItem.position.x += GameSceneConstants.batFollowFingerRatio * delta
                       }
                       
                   }
               }
               
           }
       }

       private func spritesCovergeOnBat()->Void
       {
        gameVars.grid.spritesConvergeEveryFrame(GameSceneConstants.frontLayer.position, GameSceneConstants.bat.position, GameSceneConstants.gemConvergeSpeed)
       }
       private func skullsFollowBat()->Void
       {
        gameVars.grid.skullsFollowPlayerEveryFrame(GameSceneConstants.frontLayer.position, GameSceneConstants.bat.position, GameSceneConstants.skullFollowSpeed)
       }

    
}
