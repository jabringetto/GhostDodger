//
//  GameScene_Physics.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 1/24/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit

struct PhysicsCategory {
     static let None: UInt32 = 0
     static let All: UInt32 = UInt32.max
     static let Bat: UInt32 = 0b1   // 1
     static let Gem: UInt32 = 0b10  // 2
     static let Coin: UInt32 = 0b11  // 3
     static let Skull: UInt32 = 0b100 // 4
     static let Virus: UInt32 = 0b101 // 5
     static let Ghost: UInt32 = 0b110 // 6
 }

extension GameScene: SKPhysicsContactDelegate {
    func configurePhysicsWorld() {
          physicsWorld.gravity = CGVector(dx: 0, dy: 0)
          physicsWorld.contactDelegate = self
    }

    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        let firstBodyTheBat: Bool = firstBody.categoryBitMask == PhysicsCategory.Bat
        let secondBodyAGem: Bool = secondBody.categoryBitMask == PhysicsCategory.Gem
        let secondBodyACoin: Bool = secondBody.categoryBitMask == PhysicsCategory.Coin
        let secondBodyAGhost: Bool = secondBody.categoryBitMask == PhysicsCategory.Ghost
        let secondBodyASkull: Bool = secondBody.categoryBitMask == PhysicsCategory.Skull

        if firstBodyTheBat && (secondBodyAGem || secondBodyACoin || secondBodyAGhost || secondBodyASkull) {

            if let itemSprite = secondBody.node as? SKSpriteNode {
                gameVars.grid.removeSpriteFromPersistence(sprite: itemSprite)

                if !secondBodyASkull {
                    itemSprite.physicsBody = nil
                    gameVars.currentlyCapturedItem = itemSprite
                    let itemKey: String =  String(Float(itemSprite.position.x)) + String(Float(itemSprite.position.y))
                    gameVars.grid.addConvergingPlayerSpriteForKey(sprite: itemSprite, key: itemKey)
                } else {
                    playSound(gameVars.buzzerSoundEffect)
                    gameVars.bat.die()
                    gameVars.healthMeter.updateGreenBar(gameVars.bat.healthPoints,
                                                        GameSceneConstants.batMaxHealthPoints)

                }

                if secondBodyAGhost {
                    playSound(gameVars.buzzerSoundEffect)
                    gameVars.bat.hitByVirus()
                    gameVars.healthMeter.updateGreenBar(gameVars.bat.healthPoints,
                                                        GameSceneConstants.batMaxHealthPoints)

                } else if secondBodyAGem || secondBodyACoin {

                    if secondBodyAGem {
                        playSound(gameVars.treasureSoundEffect)
                    }
                    if secondBodyACoin {
                        playSound(gameVars.coinSoundEffect)
                    }

                    playerGetsTreasure(itemSprite)

                }

            }

        }

    }

}
