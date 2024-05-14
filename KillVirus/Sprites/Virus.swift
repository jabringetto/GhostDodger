//
//  Virus.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 4/29/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

final class Virus: GameSprite {

    var virusTextures = [SKTexture]()
    var virusAnimation = SKAction()
    var randomFollowFactor: CGFloat = 1.0 + CGFloat.random(in: 0...4)/10 - 0.2
    let gameVars = GameSceneVars()

    convenience init(_ itemType: GameItemType) {
        if itemType == GameItemType.virus {
            self.init(imageNamed: "Virus0001")
            setupTexturesAndAnimation()
            setupPhysics()

        } else {
          self.init()
        }

    }
    func setupTexturesAndAnimation() {
        virusTextures = setupTextures("Virus")
        virusAnimation = SKAction.animate(with: virusTextures, timePerFrame: GameSceneConstants.virusWithFaceAnimationTimePerFrame)
        let forever = SKAction.repeat(virusAnimation, count: -1)
        self.run(forever)
        self.xScale = GameSceneConstants.virusScaleFactor
        self.yScale = GameSceneConstants.virusScaleFactor

    }
    func setupPhysics() {
          self.physicsBody = SKPhysicsBody.init(circleOfRadius: self.size.width*GameSceneConstants.virusPhysicsBodySizeRatio)
          self.physicsBody?.affectedByGravity = false
          self.physicsBody?.categoryBitMask = PhysicsCategory.Virus
          self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
     }
    func followLikeAVirus(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat, forceFieldDeployed: Bool, cycloneDeployed: Bool, radius: CGFloat) {
        let inForceFieldRadius: Bool = isWithinRadiusOfTarget(layerPosition, targetPosition, radius: radius)
        var cyclonePosition = targetPosition
        cyclonePosition.y -= GameSceneConstants.cyclonePositionDelta

        let withinCycloneOuterRadius = isWithinRadiusOfTarget(layerPosition, cyclonePosition, radius: radius * GameSceneConstants.cycloneOuterRadiusMultiplier)
        let withinCycloneInnerRadius = isWithinRadiusOfTarget(layerPosition, cyclonePosition, radius: radius * GameSceneConstants.cycloneInnerRadiusMultiplier)

        var speed = followSpeed * GameSceneConstants.virusNominalFollowSpeedMultiplier

        if forceFieldDeployed && inForceFieldRadius {
            speed = followSpeed * GameSceneConstants.virusForceFieldSpeedMultiplier
            followPoint(layerPosition, targetPosition, speed)
        } else if cycloneDeployed && withinCycloneOuterRadius {
            followPoint(layerPosition, cyclonePosition, speed * GameSceneConstants.virusCycloneSpeedMultiplier)
            if withinCycloneInnerRadius {
               convergingOnCyclone = true
            }
        } else {
            followPointWithinYRange(layerPosition, targetPosition, speed * randomFollowFactor, yRange: GameSceneConstants.virusFollowRange * randomFollowFactor)
        }
        if convergingOnCyclone {
            convergeOnPointAndShrink(layerPosition, cyclonePosition, speed * GameSceneConstants.virusConvergenceSpeedMultiplier)
        }

    }

}
