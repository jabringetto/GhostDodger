//
//  VirusWithFace.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 5/3/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

class VirusWithFace: SKSpriteNode
{
    
    var virusTextures = [SKTexture]()
    var virusAnimation = SKAction()
    
    convenience init(_ itemType: GameItemType)
     {
         if(itemType == GameItemType.virus)
         {
             self.init(imageNamed:"VirusWithFace0001")
             setupTexturesAndAnimation()
             //setupPhysics()
         }
         else
         {
           self.init()
         }
         
     }
    func setupTexturesAndAnimation()->Void
     {
         virusTextures = setupTextures("VirusWithFace")
        virusAnimation = SKAction.animate(with: virusTextures, timePerFrame: GameSceneConstants.virusAnimationTimePerFrame *  0.5)
         let forever = SKAction.repeat(virusAnimation,count: -1)
         self.run(forever)
     
     }
//     func setupPhysics()->Void
//     {
//           self.physicsBody = SKPhysicsBody.init(circleOfRadius:self.size.width*GameSceneConstants.virusPhysicsBodySizeRatio)
//           self.physicsBody!.affectedByGravity = false
//           self.physicsBody?.categoryBitMask = PhysicsCategory.Virus
//           self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
//      }


}
