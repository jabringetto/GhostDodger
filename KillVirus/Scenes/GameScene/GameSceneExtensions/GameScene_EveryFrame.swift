//
//  GameScene_EveryFrame.swift
//  VirusDodger
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
             forceFieldActions()
             cycloneActions()
             spritesCovergeOnPlayer()
             enemiesFollowPlayer()
             incrementBatCounters()
             incrementPersistenceCounter()
             moveAndFadePointLabels()
          }
          else if (gameVars.bat.isDead)
          {
              batAfterDeath()
          }
          else if (gameVars.isCountingDown)
          {
               countdownToPlay()
          }
      
        
       }
       private func countdownToPlay()->Void
       {
          gameVars.countdownCounter -= 1
          gameVars.countdownAnnouncer.updateCounterLabel(gameVars.countdownCounter)
        if(gameVars.countdownCounter == GameSceneConstants.finalCountdownDuration)
          {
            gameVars.countdownAnnouncer.getReadyLabel.isHidden = true
         }
          if (gameVars.countdownCounter < GameSceneConstants.finalCountdownDuration)
          {
            let scaleFactor = CGFloat(gameVars.countdownCounter) / CGFloat(GameSceneConstants.finalCountdownDuration)
            gameVars.countdownAnnouncer.size.width *= scaleFactor
            gameVars.countdownAnnouncer.size.height *= scaleFactor
          }
          if gameVars.countdownCounter == 0
          {
             gameVars.countdownAnnouncer.removeAllChildren()
             gameVars.countdownAnnouncer.removeFromParent()
             gameVars.gamePausedState = 0
             gameVars.pauseButton.isHidden = false
             gameVars.upgradeButton.isHidden = false
             gameVars.countdownCounter =  GameSceneConstants.totalCountdownDuration
             gameVars.isCountingDown = false
          }
       }
       private func moveBackgroundLayers()->Void
       {
          
        if(gameVars.backLayer.position.y < abs(gameVars.roundEndPosition))
        {
            var newPosition = gameVars.backLayer.position
            newPosition.y += GameSceneConstants.nominalBackgroundSpeed
            gameVars.backLayer.position.y = newPosition.y
        }
        else
        {
            if(gameVars.bat.parent != nil && gameVars.pauseButton.parent != nil)
            {
                gameVars.bat.immobilized = true
                gameVars.bat.removeFromParent()
                gameVars.pauseButton.removeFromParent()
                
            }
        }
          
       }
       private func forceFieldActions()->Void
       {
        if(gameVars.forceFieldDeployed)
        {
            gameVars.forceField.position = gameVars.bat.position
            gameVars.forceField.timerCountDown()
        }
          
        
       }
       private func cycloneActions()->Void
       {
        if(gameVars.cycloneDeployed)
        {
            gameVars.cyclone.position.x = gameVars.bat.position.x
            gameVars.cyclone.position.y = gameVars.bat.position.y - GameSceneConstants.cyclonePositionDelta
            gameVars.cyclone.timerCountDown()
        }
        
       
       }
       private func batFollowFinger()->Void
       {
            let batIsMobile = gameVars.screenTouched && !gameVars.bat.isHitByVirus && !gameVars.bat.immobilized
           if(batIsMobile)
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
        gameVars.grid.spritesConvergeOnPlayer(gameVars.backLayer.position, gameVars.bat.position, GameSceneConstants.gemConvergeSpeed)
       }
       private func enemiesFollowPlayer()->Void
       {
        gameVars.grid.spritesFollowPlayerEveryFrame(gameVars.backLayer.position, gameVars.bat.position, gameVars.skullFollowSpeed)
       }
       private func incrementBatCounters()->Void
       {
        if(!gameVars.bat.immobilized)
        {
            gameVars.bat.incrementVirusHitCounter()
            gameVars.bat.incrementHealthPointsHealingCounter()
            gameVars.healthMeter.updateGreenBar(gameVars.bat.healthPoints, GameSceneConstants.batMaxHealthPoints)

        }
      
       }
       private func incrementPersistenceCounter()->Void
       {
         gameVars.persistenceCounter += 1
          if(gameVars.persistenceCounter == 60)
          {
              gameVars.persistenceCounter = 0
              gameVars.gameInProgress = true
              savePersistentValues()
          }
       }
       private func batAfterDeath()->Void
       {
        
        if(gameVars.bat.position.x > GameSceneConstants.batDeathConvergenceThreshold)
        {
            gameVars.bat.position.x -= GameSceneConstants.batDeathConvergeSpeed
        }
        else if (gameVars.bat.position.x < -GameSceneConstants.batDeathConvergenceThreshold)
        {
            gameVars.bat.position.x += GameSceneConstants.batDeathConvergeSpeed
        }
        if(gameVars.bat.position.y > GameSceneConstants.batDeathConvergenceThreshold)
        {
            gameVars.bat.position.y -= GameSceneConstants.batDeathConvergeSpeed
        }
        else if (gameVars.bat.position.y < -GameSceneConstants.batDeathConvergenceThreshold)
        {
            gameVars.bat.position.y += GameSceneConstants.batDeathConvergeSpeed
        }
        if( gameVars.bat.xScale < GameSceneConstants.batDeathScaleThreshold)
        {
            gameVars.bat.xScale += GameSceneConstants.batDeathScaleSpeed
            gameVars.bat.yScale += GameSceneConstants.batDeathScaleSpeed
        }
     
        if(gameVars.bat.zRotation < CGFloat.pi)
        {
            gameVars.bat.zRotation += GameSceneConstants.batDeathRotationSpeed
        }
        else if (gameVars.bat.alpha >= GameSceneConstants.batDeathAlphaThreshold)
        {
            gameVars.bat.alpha -= GameSceneConstants.batDeathAlphaSpeed

        }
        if(gameVars.bat.alpha <= GameSceneConstants.batDeathAlphaThreshold)
        {
            let midPoint = gameVars.gameOverBackLayerDisplacement * 0.5
            let greaterThanZero = gameVars.backLayer.position.y > 0.0
            
            if(gameVars.backLayer.position.y > midPoint)
            {
                var newPosition = gameVars.backLayer.position
                newPosition.y -= gameVars.batDeathBackgroundVelocity
                gameVars.batDeathBackgroundVelocity += GameSceneConstants.batDeathBackgroundAcceration
                gameVars.backLayer.position.y = newPosition.y
            }
            if(gameVars.backLayer.position.y < midPoint && greaterThanZero)
            {
                 var newPosition = gameVars.backLayer.position
                newPosition.y -= gameVars.batDeathBackgroundVelocity
                gameVars.batDeathBackgroundVelocity -= GameSceneConstants.batDeathBackgroundAcceration
                gameVars.backLayer.position.y = newPosition.y
                if(gameVars.backLayer.position.y < GameSceneConstants.gameOverConvergenceYPos)
                {
                    gameVars.batDeathBackgroundVelocity *= GameSceneConstants.gameOverConvergenceCoefficent
                    
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
