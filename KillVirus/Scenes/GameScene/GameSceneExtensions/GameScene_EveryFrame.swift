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
          if(gameVars.gamePausedState == 0)
          {
             moveBackgroundLayers()
             batFollowFinger()
             spritesCovergeOnPlayer()
             skullsFollowPlayer()
             incrementBatCounters()
             moveAndFadePointLabels()
          }
          else if (gameVars.bat.isDead)
          {
            batAfterDeath()
          }
      
        
       }
       private func moveBackgroundLayers()->Void
       {
          var newPosition = gameVars.backLayer.position
          newPosition.y += GameSceneConstants.nominalBackgroundSpeed
          gameVars.backLayer.position.y = newPosition.y
          
       }
       private func batFollowFinger()->Void
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
       private func batAfterDeath()->Void
       {
        
        let convergeSpeed:CGFloat = 0.75
        let scaleSpeed:CGFloat = 0.03
        
        if(gameVars.bat.position.x > 1.0)
        {
            gameVars.bat.position.x -= convergeSpeed
        }
        else if (gameVars.bat.position.x < -1.0)
        {
            gameVars.bat.position.x += convergeSpeed
        }
        if(gameVars.bat.position.y > 1.0)
        {
            gameVars.bat.position.y -= convergeSpeed
        }
        else if (gameVars.bat.position.y < -1.0)
        {
            gameVars.bat.position.y += convergeSpeed
        }
        if( gameVars.bat.xScale < 0.8)
        {
            gameVars.bat.xScale += scaleSpeed
            gameVars.bat.yScale += scaleSpeed
        }
     
        if(gameVars.bat.zRotation < CGFloat.pi)
        {
            gameVars.bat.zRotation += scaleSpeed * 2.0
        }
        else if (gameVars.bat.alpha >= 0.01)
        {
            gameVars.bat.alpha -= scaleSpeed * 0.4

        }
        if(gameVars.bat.alpha <= 0.01)
        {
        
            if(gameVars.backLayer.position.y > gameVars.gameOverBackLayerDisplacement * 0.5)
            {
                var newPosition = gameVars.backLayer.position
                newPosition.y -= gameVars.batDeathBackgroundVelocity
                gameVars.batDeathBackgroundVelocity += GameSceneConstants.batDeathBackgroundAcceration
                gameVars.backLayer.position.y = newPosition.y
            }
            if(gameVars.backLayer.position.y < gameVars.gameOverBackLayerDisplacement * 0.5 && gameVars.backLayer.position.y > 0)
            {
                 var newPosition = gameVars.backLayer.position
                newPosition.y -= gameVars.batDeathBackgroundVelocity
                gameVars.batDeathBackgroundVelocity -= GameSceneConstants.batDeathBackgroundAcceration
                gameVars.backLayer.position.y = newPosition.y
                if(gameVars.backLayer.position.y < 300)// && gameVars.batDeathBackgroundVelocity > 0.0)
                {
                    gameVars.batDeathBackgroundVelocity *= 0.99
                    
                }
                if( gameVars.batDeathBackgroundVelocity < 0.0)
                {
                    gameVars.batDeathBackgroundVelocity = 0.0
                }


            }
         
        }
        
       }
       
       private func moveAndFadePointLabels()->Void
       {
        
            for key:String in gameVars.pointsLabels.keys
            {
                guard let label:SKLabelNode = gameVars.pointsLabels[key] else {return}
                label.alpha *= GameSceneConstants.pointLabelFadeMultiplier
                if(label.position.x > 0)
                {
                    label.position.x -= GameSceneConstants.pointLabelVelocity
                }
                else
                {
                    label.position.x += GameSceneConstants.pointLabelVelocity
                }
                if(label.alpha < GameSceneConstants.pointLabelAlphaThreshold)
                {
                    label.removeFromParent()
                    gameVars.pointsLabels.removeValue(forKey: key)
                    
                }
            }

       }

    
}
