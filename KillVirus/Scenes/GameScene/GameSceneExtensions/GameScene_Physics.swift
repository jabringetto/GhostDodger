//
//  GameScene_Physics.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 1/24/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit

struct PhysicsCategory
 {
     static let None  :UInt32 = 0
     static let All   :UInt32 = UInt32.max
     static let Bat   :UInt32 = 0b1   // 1
     static let Gem   :UInt32 = 0b10  // 2
     static let Coin  :UInt32 = 0b11  // 3
     static let Skull :UInt32 = 0b100 // 4
     static let Virus :UInt32 = 0b101 // 5
 }

extension GameScene: SKPhysicsContactDelegate
{
    func configurePhysicsWorld()->Void
    {
          physicsWorld.gravity = CGVector(dx: 0, dy: 0)
          physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        let firstBodyTheBat:Bool = firstBody.categoryBitMask == PhysicsCategory.Bat
        let secondBodyAGem:Bool = secondBody.categoryBitMask == PhysicsCategory.Gem
        let secondBodyACoin:Bool = secondBody.categoryBitMask == PhysicsCategory.Coin
        let secondBodyAVirus:Bool = secondBody.categoryBitMask == PhysicsCategory.Virus
        let secondBodyASkull:Bool = secondBody.categoryBitMask == PhysicsCategory.Skull
        
        if(firstBodyTheBat && (secondBodyAGem || secondBodyACoin || secondBodyAVirus || secondBodyASkull))
        {

            if let itemSprite = secondBody.node as? SKSpriteNode
            {
                if(!secondBodyASkull)
                {
                    itemSprite.physicsBody = nil
                    gameVars.currentlyCapturedItem = itemSprite
                    let itemKey:String =  String(Float(itemSprite.position.x)) + String(Float(itemSprite.position.y))
                    gameVars.grid.addConvergingSpriteForKey(sprite:itemSprite, key: itemKey)
                }
                else
                {
                    playSound(gameVars.buzzerSoundEffect)
                    gameVars.bat.die()
                    gameVars.healthMeter.updateGreenBar(gameVars.bat.healthPoints, GameSceneConstants.batMaxHealthPoints)
                   
                }
              
                if(secondBodyAVirus)
                {
                    playSound(gameVars.buzzerSoundEffect)
                    gameVars.bat.hitByVirus()
                    gameVars.healthMeter.updateGreenBar(gameVars.bat.healthPoints, GameSceneConstants.batMaxHealthPoints)
                    
                }
                else if (secondBodyAGem || secondBodyACoin)
                {
                    
                    playSound(gameVars.treasureSoundEffect)
                    playerGetsTreasure(itemSprite)
                    gameVars.scoreLabel.text = GameSceneConstants.scoreLabelPrefix + String(gameVars.score)
                    
                    
                }
             
            }
            
        }
        
    }
 
    
    
}
