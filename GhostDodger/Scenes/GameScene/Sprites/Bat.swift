//
//  Bat.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 12/13/19.
//  Copyright © 2019 Jeremy Bringetto. All rights reserved.
//

// import UIKit
import SpriteKit

protocol BatDelegate: AnyObject {

    func batDied()
    func savePersistentValues()
}

final class Bat: SKSpriteNode {

    let greenEyeRight = SKSpriteNode(imageNamed: "VirusBody")
    let greenEyeLeft = SKSpriteNode(imageNamed: "VirusBody")
    let deadEyeRight = SKSpriteNode(imageNamed: "DeadEyeRight")
    let deadEyeLeft = SKSpriteNode(imageNamed: "DeadEyeLeft")
    let flapKey =  "flapWingsForever"
    let ghostHitCounterDuration: Int = 30
    var batTextures = [SKTexture]()
    var batAnimation = SKAction()
    var flapWingsForever = SKAction()
    var noAnimation = SKAction()
    var ghostHitCounter = 0
    var isHitByGhost = false
    var healthPoints: UInt = 20
    var healthPointsHealingCounter = 0
    var healTimeInSeconds: Int = 4
    var isDead = false
    var immobilized = false
    weak var delegate: BatDelegate?

    convenience init() {
        self.init(imageNamed: "Bat0001")
        addTexturesAndScale()
        setupAnimation(timePerFrame: GameSceneConstants.batAnimationTimePerFrame)
        setupPhysics()
        addGreenEyes()
        addDeadEyes()
    }
    func addTexturesAndScale() {
        batTextures = setupTextures("Bat")
        self.xScale = GameSceneConstants.batScale
        self.yScale = GameSceneConstants.batScale
    }
    func setupAnimation(timePerFrame: TimeInterval) {

        batAnimation = SKAction.animate(with: batTextures, timePerFrame: timePerFrame)
        flapWingsForever  = SKAction.repeat(batAnimation, count: -1)
        self.run(flapWingsForever, withKey: flapKey)

    }
    func flipAnimation() {
        let numTextures: UInt = UInt(batTextures.count)
        guard numTextures > 1 else { return }
        let midPoint = numTextures/2
        var firstHalfTextures = [SKTexture]()
        var secondHalfTextures = [SKTexture]()
        for (index, texture) in batTextures.enumerated() {
            if index < midPoint {
                firstHalfTextures.append(texture)
            } else {
                 secondHalfTextures.append(texture)
            }
        }
        batTextures =  secondHalfTextures + firstHalfTextures
        setupAnimation(timePerFrame: GameSceneConstants.batAnimationTimePerFrame)
    }

    func setupPhysics() {
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: self.size.width * GameSceneConstants.batPhysicsBodySizeRatio)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Bat
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Gem
    }
    private func addGreenEyes() {
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
    private func addDeadEyes() {
        deadEyeRight.xScale = GameSceneConstants.batScale * 1.9
        deadEyeRight.yScale = GameSceneConstants.batScale * 1.9
        deadEyeRight.position = CGPoint(x: 12.0, y: 21.0)
        deadEyeLeft.xScale = GameSceneConstants.batScale * 1.9
        deadEyeLeft.yScale = GameSceneConstants.batScale * 1.9
        deadEyeLeft.position = CGPoint(x: -22.0, y: 21.0)
        deadEyeRight.isHidden = true
        deadEyeLeft.isHidden = true
        self.addChild(deadEyeRight)
        self.addChild(deadEyeLeft)
    }

    func hitByGhost() {
        guard healthPoints > 0 else { die() ; return }
        self.healthPoints -= 1
        greenEyeRight.isHidden = false
        greenEyeLeft.isHidden = false
        self.removeAction(forKey: flapKey)
        setupAnimation(timePerFrame: GameSceneConstants.batAnimationTimePerFrame*4.0)
        self.isHitByGhost = true
        self.delegate?.savePersistentValues()
    }

    func incrementVirusHitCounter() {
        if self.isHitByGhost {
            ghostHitCounter += 1
        }
        if ghostHitCounter == ghostHitCounterDuration {
            self.isHitByGhost = false
            greenEyeRight.isHidden = true
            greenEyeLeft.isHidden = true
            ghostHitCounter = 0
            setupAnimation(timePerFrame: GameSceneConstants.batAnimationTimePerFrame)

        }
    }
    func incrementHealthPointsHealingCounter() {
        if healthPoints < GameSceneConstants.batMaxHealthPoints {
            healthPointsHealingCounter += 1
            if healthPointsHealingCounter >= 60 * healTimeInSeconds {
                healthPointsHealingCounter = 0
                healthPoints += 1
            }
        }
    }
    func die() {
        isDead = true
        healthPoints = 0
        self.physicsBody = nil
        greenEyeRight.isHidden = true
        greenEyeLeft.isHidden = true
        deadEyeRight.isHidden = false
        deadEyeLeft.isHidden = false
        self.removeAction(forKey: flapKey)
        self.delegate?.batDied()
    }

}
