//
//  Virus.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 4/29/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

final class Virus: SKSpriteNode
{
    var virusTextures = [SKTexture]()
    var virusAnimation = SKAction()
    
    convenience init(_ itemType: GameItemType)
    {
        if(itemType == GameItemType.virus)
        {
            self.init(imageNamed:"Virus0001")
            setupTexturesAndAnimation()
            setupPhysics()
        }
        else
        {
          self.init()
        }
        
    }
    func setupTexturesAndAnimation()->Void
    {
        virusTextures = setupTextures("Virus")
        virusAnimation = SKAction.animate(with: virusTextures, timePerFrame: GameSceneConstants.virusAnimationTimePerFrame)
        let forever = SKAction.repeat(virusAnimation,count: -1)
        self.run(forever)
        self.xScale = GameSceneConstants.virusScaleFactor
        self.yScale = GameSceneConstants.virusScaleFactor
    
    }
    func setupPhysics()->Void
    {
          self.physicsBody = SKPhysicsBody.init(circleOfRadius:self.size.width*GameSceneConstants.virusPhysicsBodySizeRatio)
          self.physicsBody!.affectedByGravity = false
          self.physicsBody?.categoryBitMask = PhysicsCategory.Virus
          self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
     }

    
}
