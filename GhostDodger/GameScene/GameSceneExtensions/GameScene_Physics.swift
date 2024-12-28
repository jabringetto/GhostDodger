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
          optimizePhysics()
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
        
        guard firstBody.categoryBitMask == PhysicsCategory.Bat else { return }
        
        switch secondBody.categoryBitMask {
        case PhysicsCategory.Coin :
            guard let coinSprite = secondBody.node as? SKSpriteNode else { break }
            captureAndConverge(coinSprite)
            playerGetsTreasure(coinSprite)
            
        case PhysicsCategory.Gem:
            guard let gemSprite = secondBody.node as? SKSpriteNode else { break }
            captureAndConverge(gemSprite)
            playerGetsTreasure(gemSprite)
            
        case PhysicsCategory.Ghost:
            guard let ghostSprite = secondBody.node as? SKSpriteNode else { break }
            captureAndConverge(ghostSprite)
            playerTouchesEnemy(.ghost)
            
        case PhysicsCategory.Skull:
            playerTouchesEnemy(.skull)
        
        default:
            guard let someSprite = secondBody.node as? SKSpriteNode else { break }
            print("Unexpected physics contact with sprite; \(someSprite)")
            guard let someSpriteName = someSprite.name  else { break }
            print("Unexpected physics contact with sprite named; \(someSpriteName)")
   
        }
    }

    private func optimizePhysics() {
        physicsWorld.speed = 1.0
        physicsWorld.gravity = .zero
        
        // Reduce physics body precision for better performance
        let scale: CGFloat = 0.8 // Adjust between 0.5-1.0 based on needs
        
        // Apply to all physics bodies
        enumerateChildNodes(withName: "//.*") { node, _ in
            if let body = node.physicsBody {
                // Disable precise collision detection for better performance
                body.usesPreciseCollisionDetection = false
                
                // Only optimize moving bodies (non-static)
                if !body.isDynamic {
                    return
                }
                
                // Create simplified circular physics bodies
                if let sprite = node as? SKSpriteNode {
                    let size = sprite.size
                    let radius = min(size.width, size.height) * scale * 0.5
                    let newBody = SKPhysicsBody(circleOfRadius: radius)
                    
                    // Copy over the important physics properties
                    newBody.isDynamic = true
                    newBody.affectedByGravity = false
                    newBody.allowsRotation = false
                    newBody.categoryBitMask = body.categoryBitMask
                    newBody.collisionBitMask = body.collisionBitMask
                    newBody.contactTestBitMask = body.contactTestBitMask
                    
                    node.physicsBody = newBody
                }
            }
        }
    }

}
