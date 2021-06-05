//
//  Gem.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 12/22/18.
//  Copyright © 2018 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

final class Gem: GameSprite {

    var pointValue: UInt = 0
    var spinSpeed: UInt = 1
    private var perFrame: TimeInterval = GameSceneConstants.gemRotationConstant
    private var spinAnimation = SKAction()
    private var spinTextures = [SKTexture]()

    convenience init(_ gemType: GameItemType) {

        if gemType == GameItemType.ruby {
            self.init(imageNamed: "RubyFrame0001")
            addRubyTextures()
            commonSetup(gemType)

        } else if gemType ==  GameItemType.emerald {
             self.init(imageNamed: "Emerald0001")
             addEmeraldTextures()
             commonSetup(gemType)
        } else {
            self.init()
        }
    }
    private func commonSetup(_ gemType: GameItemType) {
        spinForever()
        setupPhysics()
        assignPointValue(gemType)
        self.xScale = GameSceneConstants.gemScale
        self.yScale = GameSceneConstants.gemScale
    }
    private func addRubyTextures() {
        spinTextures = setupTextures("RubyFrame")
    }
    private func addEmeraldTextures() {
        spinTextures = setupTextures("Emerald")
    }
    private func spinForever() {
        spinSpeed = UInt.random(in: 1 ..< 4)

        if spinSpeed > 0 {
            perFrame /= Double(spinSpeed)
            spinAnimation = SKAction.animate(with: spinTextures, timePerFrame: perFrame)
            let spinForever = SKAction.repeat(spinAnimation, count: -1)
            self.run(spinForever, withKey: "spinAction")
        }
    }
    func spinSlowly() {
        self.removeAction(forKey: "spinAction")
        perFrame = GameSceneConstants.gemRotationConstant
        spinAnimation = SKAction.animate(with: spinTextures, timePerFrame: perFrame)
        let spinForever = SKAction.repeat(spinAnimation, count: -1)
        self.run(spinForever, withKey: "spinAction")
    }
    private func assignPointValue(_ gemType: GameItemType) {
        var baseValue = GameSceneConstants.basePointValueEmerald
        if gemType == .ruby {
            baseValue = GameSceneConstants.basePointValueRuby
        }
        pointValue = baseValue * spinSpeed

    }

    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: self.size.width*GameSceneConstants.gameItemPhysicsRadius)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Gem
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
    }
    func followCyclone(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat, cycloneDeployed: Bool, radius: CGFloat) {
           var cyclonePosition = targetPosition
        cyclonePosition.y -= GameSceneConstants.cyclonePositionDelta
        let withinCycloneOuterRadius = isWithinRadiusOfTarget(layerPosition, cyclonePosition, radius: radius * GameSceneConstants.cycloneOuterRadiusMultiplier)
        let withinCycloneInnerRadius = isWithinRadiusOfTarget(layerPosition, cyclonePosition, radius: radius * GameSceneConstants.cycloneInnerRadiusMultiplier)

           if cycloneDeployed && withinCycloneOuterRadius {
            followPoint(layerPosition, cyclonePosition, followSpeed * 1.5)
               if withinCycloneInnerRadius {
                   convergingOnCyclone = true
                   convergeOnPointAndShrink(layerPosition, cyclonePosition, speed * 0.25)
               }

           }
           if convergingOnCyclone {
                convergeOnPointAndShrink(layerPosition, cyclonePosition, speed * 0.25)
           }

       }

}
