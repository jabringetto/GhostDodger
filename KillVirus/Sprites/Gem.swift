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
    
    var pointValue:UInt = 0
    var spinSpeed:UInt = 1
    private var spinAnimation = SKAction()
    private var spinTextures = [SKTexture]()
    private var perFrame:TimeInterval = GameSceneConstants.gemRotationConstant

    convenience init(_ gemType: GameItemType)
    {
        
        if(gemType == GameItemType.ruby)
        {
            self.init(imageNamed:"RubyFrame0001")
            addRubyTextures()
            commonSetup(gemType)
            
        }
        else if (gemType ==  GameItemType.emerald)
        {
             self.init(imageNamed:"Emerald0001")
             addEmeraldTextures()
             commonSetup(gemType)
        }
        else
        {
            self.init()
        }
    }
    private func commonSetup(_ gemType: GameItemType)->Void
    {
        spinForever()
        setupPhysics()
        assignPointValue(gemType)
        self.xScale = GameSceneConstants.gemScale
        self.yScale = GameSceneConstants.gemScale
    }
    private func addRubyTextures()->Void
    {
        spinTextures = setupTextures("RubyFrame")
    }
    private func addEmeraldTextures()->Void
    {
        spinTextures = setupTextures("Emerald")
    }
    private func spinForever()->Void
    {
        spinSpeed = UInt.random(in: 1 ..< 4)
              
        if(spinSpeed > 0)
        {
            perFrame = perFrame/Double(spinSpeed)
            spinAnimation = SKAction.animate(with: spinTextures, timePerFrame: perFrame)
            let spinForever = SKAction.repeat(spinAnimation,count: -1)
            self.run(spinForever)
        }
    }
    private func assignPointValue(_ gemType: GameItemType)->Void
    {
        var baseValue = GameSceneConstants.basePointValueEmerald
        if(gemType == .ruby)
        {
            baseValue = GameSceneConstants.basePointValueRuby
        }
        pointValue = baseValue * spinSpeed
      
    }

    private func setupPhysics()->Void
    {
        self.physicsBody = SKPhysicsBody.init(circleOfRadius:self.size.width*GameSceneConstants.gameItemPhysicsRadius)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Gem
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
    }


   
  
}
