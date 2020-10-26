//
//  Whirlpool.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 9/10/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//
import SpriteKit
import Foundation

final class Whirlpool:SKSpriteNode
{
    
    var whirlpoolTextures = [SKTexture]()
    var whirlpoolAnimation = SKAction()
    var whirlpoolForever = SKAction()
    var countdownLabel = SKLabelNode()
 
    
    convenience init(timePerFrame:TimeInterval)
    {
          self.init(imageNamed:"Whirlpool0001")
          addTexturesAndScale()
          setupAnimation(timePerFrame:timePerFrame)
          addCountdownLabel()
       
    }
    private func addTexturesAndScale()->Void
     {
         whirlpoolTextures = setupTextures("Whirlpool")
        self.xScale = 0.5 //GameSceneConstants.forceFieldScaleConstant
        self.yScale = 0.5 // GameSceneConstants.forceFieldScaleConstant 
     }
    private func addCountdownLabel()->Void
    {
        countdownLabel.fontSize = 48
        countdownLabel.fontColor = UIColor.white
        self.addChild(countdownLabel)
    }
    private func setupAnimation(timePerFrame:TimeInterval)->Void
    {
        whirlpoolAnimation  = SKAction.animate(with: whirlpoolTextures, timePerFrame:timePerFrame)
        whirlpoolForever = SKAction.repeat(whirlpoolAnimation,count: -1)
        self.run(whirlpoolForever)

    }
}


