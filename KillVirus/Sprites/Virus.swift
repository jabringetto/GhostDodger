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

protocol VirusDelegate:AnyObject
{
    
    func virusWentDownCyclone(virus:SKSpriteNode)->Void
}

final class Virus: SKSpriteNode
{
    var delegate:VirusDelegate?
    var virusTextures = [SKTexture]()
    var virusAnimation = SKAction()
    var randomFollowFactor:CGFloat = 1.0 + CGFloat.random(in:0...4)/10 - 0.2
    let gameVars = GameSceneVars()
    var convergingOnCyclone = false
          
    
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
          self.physicsBody?.affectedByGravity = false
          self.physicsBody?.categoryBitMask = PhysicsCategory.Virus
          self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
     }
    func followLikeAVirus(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat, forceFieldDeployed:Bool, cycloneDeployed:Bool, radius: CGFloat)->Void
    {
        let inForceFieldRadius:Bool = isWithinRadiusOfTarget(layerPosition, targetPosition, radius: radius)
        var cyclonePosition = targetPosition
        cyclonePosition.y -= 150.0
        let withinCycloneOuterRadius = isWithinRadiusOfTarget(layerPosition, cyclonePosition, radius: radius * 1.2)
        let withinCycloneInnerRadius = isWithinRadiusOfTarget(layerPosition, cyclonePosition, radius: radius * 0.3)
        
        
        var speed = followSpeed * 0.5
        
        if(forceFieldDeployed && inForceFieldRadius)
        {
            speed = followSpeed * -3.0
            followPoint(layerPosition, targetPosition, speed)
        }
        else if (cycloneDeployed && withinCycloneOuterRadius)
        {
            followPoint(layerPosition, cyclonePosition, speed * 2.4)
            if(withinCycloneInnerRadius)
            {
               convergingOnCyclone = true
               self.delegate?.virusWentDownCyclone(virus: self)
            }
        }
        else
        {
            followPointWithinYRange(layerPosition, targetPosition, speed * randomFollowFactor, yRange: GameSceneConstants.skullFollowRange * 0.5 * randomFollowFactor)
        }
        if(convergingOnCyclone)
        {
            convergeOnPointAndShrink(layerPosition, cyclonePosition, speed * 0.25)
        }
        
    }

    
}
