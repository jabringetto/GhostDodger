//
//  Ghost.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 12/30/21.
//  Copyright © 2021 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

final class Ghost: GameSprite {
    
    private var ghostTextures = [SKTexture]()
    private var ghostAnimation = SKAction()
    var randomFollowFactor: CGFloat = 1.0 + CGFloat.random(in: 0...4)/10 - 0.2
    
    convenience init(_ itemType: GameItemType) {
        if itemType == GameItemType.ghost {
            self.init(imageNamed: "Ghost0001")
            setupGhost()
            setupPhysics()

        } else {
          self.init()
        }
        self.xScale = GameSceneConstants.ghostScale
        self.yScale = GameSceneConstants.ghostScale

    }
    func setupGhost() {
        ghostTextures = setupTextures("Ghost")
        randomizeAnimation()

    }
    func setupPhysics() {
        let radius = self.size.width*GameSceneConstants.gameItemPhysicsRadius
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Ghost
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
    }
    func randomizeAnimation() {
        let numTextures: UInt = UInt(ghostTextures.count)
        guard numTextures > 1 else { return }
        let randomIndex = UInt.random(in: 0 ..< numTextures)
        var firstHalfTextures = [SKTexture]()
        var secondHalfTextures = [SKTexture]()
        for (index, texture) in ghostTextures.enumerated() {
            if index < randomIndex {
                firstHalfTextures.append(texture)
            } else {
                 secondHalfTextures.append(texture)
            }
        }
        ghostTextures =  secondHalfTextures + firstHalfTextures
        setupAnimation(timePerFrame: GameSceneConstants.ghostAnimationTimePerFrame)
    }
    func setupAnimation(timePerFrame: TimeInterval) {

        ghostAnimation = SKAction.animate(with: ghostTextures, timePerFrame: timePerFrame)
        let animateForever  = SKAction.repeat(ghostAnimation, count: -1)
        self.run(animateForever, withKey: "ghostAnimation")

    }
    func followLikeAGhost(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat, forceFieldDeployed: Bool, cycloneDeployed: Bool, radius: CGFloat) {
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
