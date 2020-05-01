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
    
        let atlas = SKTextureAtlas(named:"virus")
        for index in 1...40
        {
            var name:String = ""
            if(index < 10)
            {
                name = "Virus000" + String(index) + ".png"
            }
            else
            {
                name = "Virus00" + String(index) + ".png"
            }
            let texture = atlas.textureNamed(name)
            virusTextures.append(texture)
        }
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
