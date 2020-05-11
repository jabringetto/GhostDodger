//
//  Bat.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 12/13/19.
//  Copyright © 2019 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

final class Bat: SKSpriteNode {
    
    
    var batTextures = [SKTexture]()
    var batAnimation = SKAction()
    convenience init()
    {
    self.init(imageNamed:"Bat0001")
    setupTexturesAndAnimation()
    setupPhysics()
    }
    func setupTexturesAndAnimation()->Void
    {
    
        batTextures = setupTextures("Bat")
        batAnimation = SKAction.animate(with: batTextures, timePerFrame: GameSceneConstants.batAnimationTimePerFrame)
        let forever = SKAction.repeat(batAnimation,count: -1)
        self.run(forever)
        self.xScale = GameSceneConstants.batScale
        self.yScale = GameSceneConstants.batScale
    
    }
    func setupPhysics()->Void
    {
        self.physicsBody = SKPhysicsBody.init(circleOfRadius:self.size.width * GameSceneConstants.batPhysicsBodySizeRatio)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Bat
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Gem
    }
    

}
