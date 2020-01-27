//
//  Skull.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 1/17/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

final class Skull: SKSpriteNode {
    
   
    private var skullTextures = [SKTexture]()
    private var skullAnimation = SKAction()
    
    convenience init(_ itemType: GameItemType)
    {
        
        if(itemType == GameItemType.skull)
        {
            self.init(imageNamed:"Skull")
        }
        else
        {
            self.init()
        }
        self.xScale = GameSceneConstants.skullScaleFactor
        self.yScale = GameSceneConstants.skullScaleFactor
        setupSkull()
        setupPhysics()
    }
    
    func setupPhysics()->Void
    {
        self.physicsBody = SKPhysicsBody.init(circleOfRadius:self.size.width*GameSceneConstants.gameItemPhysicsRadius)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Skull
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
    }
    func setupSkull()->Void
    {
        let atlas = SKTextureAtlas(named:"skull")
     
        for index in 1...atlas.textureNames.count
        {
            var name:String = ""
            if(index < 10)
            {
                name = "Skull000" + String(index) + ".png"
            }
            else
            {
                name = "Skull00" + String(index) + ".png"
            }
            let texture = atlas.textureNamed(name)
            skullTextures.append(texture)
            skullAnimation = SKAction.animate(with: skullTextures, timePerFrame:0.02)
            let forever = SKAction.repeat(skullAnimation,count: -1)
             self.run(forever)
        }
        
    }


}
