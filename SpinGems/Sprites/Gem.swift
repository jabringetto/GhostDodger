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
    var perFrame = 0.02
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
        
        let atlas = SKTextureAtlas(named:"ruby")
        for index in 1...atlas.textureNames.count
        {
            var name:String = ""
            if(index < 10)
            {
                name = "RubyFrame000" + String(index) + ".png"
            }
            else
            {
                name = "RubyFrame00" + String(index) + ".png"
            }
            let texture = atlas.textureNamed(name)
            spinTextures.append(texture)
        }
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
        
        let atlas = SKTextureAtlas(named:"emerald")
        for index in 1...atlas.textureNames.count
        {
            var name:String = ""
            if(index < 10)
            {
                name = "Emerald000" + String(index) + ".png"
            }
            else
            {
                name = "Emerald00" + String(index) + ".png"
            }
            let texture = atlas.textureNamed(name)
            spinTextures.append(texture)
        }
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
