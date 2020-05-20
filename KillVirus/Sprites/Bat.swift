//
//  Bat.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 12/13/19.
//  Copyright © 2019 Jeremy Bringetto. All rights reserved.
//

//import UIKit
import SpriteKit

final class Bat: SKSpriteNode {
    
    let greenEyeRight = SKSpriteNode(imageNamed: "VirusBody")
    let greenEyeLeft = SKSpriteNode(imageNamed: "VirusBody")
    let flapKey =  "flapWingsForever"
    let virusHitCounterDuration:Int = 30
    var batTextures = [SKTexture]()
    var batAnimation = SKAction()
    var flapWingsForever = SKAction()
    var noAnimation = SKAction()
    var virusHitCounter = 0
    var isHitByVirus = false
    var healthPoints:Int = 20
    var healthPointsHealingCounter = 0
    var healTimeInSeconds:Int = 4
    
    convenience init()
    {
    self.init(imageNamed:"Bat0001")
    addTexturesAndScale()
    setupAnimation(timePerFrame: GameSceneConstants.batAnimationTimePerFrame)
    setupPhysics()
    addGreenEyes()
    }
    func addTexturesAndScale()->Void
    {
        batTextures = setupTextures("Bat")
        self.xScale = GameSceneConstants.batScale
        self.yScale = GameSceneConstants.batScale
    }
    func setupAnimation(timePerFrame:TimeInterval)->Void
    {
       
        batAnimation = SKAction.animate(with: batTextures, timePerFrame:timePerFrame)
        flapWingsForever  = SKAction.repeat(batAnimation,count: -1)
        self.run(flapWingsForever, withKey: flapKey)

    }
    func setupPhysics()->Void
    {
        self.physicsBody = SKPhysicsBody.init(circleOfRadius:self.size.width * GameSceneConstants.batPhysicsBodySizeRatio)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Bat
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Gem
    }
    private func addGreenEyes()->Void
    {
        greenEyeRight.xScale = GameSceneConstants.batScale * 1.9
        greenEyeRight.yScale = GameSceneConstants.batScale * 1.9
        greenEyeRight.position = CGPoint(x: 12.0, y: 21.0)
        greenEyeLeft.xScale = GameSceneConstants.batScale * 1.9
        greenEyeLeft.yScale = GameSceneConstants.batScale * 1.9
        greenEyeLeft.position = CGPoint(x: -22.0, y: 21.0)
        greenEyeRight.isHidden = true
        greenEyeLeft.isHidden = true
        self.addChild(greenEyeRight)
        self.addChild(greenEyeLeft)
    }
    func hitByVirus()->Void
    {
        if(healthPoints > 0)
        {
             self.healthPoints -= 1
        }
        else
        {
            //die
        }
     
        greenEyeRight.isHidden = false
        greenEyeLeft.isHidden = false
        self.removeAction(forKey:flapKey)
        setupAnimation(timePerFrame: GameSceneConstants.batAnimationTimePerFrame*4.0)
        self.isHitByVirus = true
    }
    func incrementVirusHitCounter()->Void
    {
        if(self.isHitByVirus)
        {
             virusHitCounter += 1
        }
        if(virusHitCounter == virusHitCounterDuration)
        {
            self.isHitByVirus = false
            greenEyeRight.isHidden = true
            greenEyeLeft.isHidden = true
            virusHitCounter = 0
            setupAnimation(timePerFrame: GameSceneConstants.batAnimationTimePerFrame)
           
        }
    }
    func incrementHealthPointsHealingCounter()->Void
    {
        if(healthPoints < GameSceneConstants.batMaxHealthPoints)
        {
            healthPointsHealingCounter += 1
            if(healthPointsHealingCounter >= 60 * healTimeInSeconds)
            {
                healthPointsHealingCounter = 0
                healthPoints += 1
            }
        }
    }
    
    

}
