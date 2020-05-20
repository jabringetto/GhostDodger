//
//  Gem.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 12/22/18.
//  Copyright © 2018 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit


final class Gem: SKSpriteNode {
    
    private (set) var spinSpeed:Int = 1
    private var spinTextures = [SKTexture]()
    var perFrame:TimeInterval = GameSceneConstants.getRotationConstant
    var spinAnimation = SKAction()

    convenience init(_ gemType: GameItemType)
    {
        
        if(gemType == GameItemType.ruby)
        {
            self.init(imageNamed:"RubyFrame0001")
            rubySetup()
            setupPhysics()
            self.xScale = GameSceneConstants.gemScale
            self.yScale = GameSceneConstants.gemScale
        }
        else if (gemType ==  GameItemType.emerald)
        {
             self.init(imageNamed:"Emerald0001")
             emeraldSetup()
             setupPhysics()
             self.xScale = GameSceneConstants.gemScale
             self.yScale = GameSceneConstants.gemScale
        }
        else
        {
            self.init()
        }
        
    }
    func rubySetup()->Void
    {
        
        spinTextures = setupTextures("RubyFrame")
        spinSpeed = Int.random(in: 1 ..< 4)
        
        if(spinSpeed > 0)
        {
            perFrame = perFrame/Double(spinSpeed)
            spinAnimation = SKAction.animate(with: spinTextures, timePerFrame: perFrame)
            let spinForever = SKAction.repeat(spinAnimation,count: -1)
            self.run(spinForever)
        }
    }
    func emeraldSetup()->Void
    {
        
        spinTextures = setupTextures("Emerald")
        spinSpeed = Int.random(in: 1 ..< 4)
        
        if(spinSpeed > 0)
        {
            perFrame = perFrame/Double(spinSpeed)
            spinAnimation = SKAction.animate(with: spinTextures, timePerFrame: perFrame)
            let spinForever = SKAction.repeat(spinAnimation,count: -1)
            self.run(spinForever)
        }
    }
    func setupPhysics()->Void
    {
        self.physicsBody = SKPhysicsBody.init(circleOfRadius:self.size.width*GameSceneConstants.gameItemPhysicsRadius)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Gem
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
    }


   
  
}
