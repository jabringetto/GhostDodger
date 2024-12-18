//
//  Skull.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 1/17/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

final class Skull: GameSprite {

    private var skullTextures = [SKTexture]()
    private var skullAnimation = SKAction()

    convenience init(_ itemType: GameItemType) {

        if itemType == GameItemType.skull {
            self.init(imageNamed: "Skull")
        } else {
            self.init()
        }
        self.xScale = GameSceneConstants.skullScaleFactor
        self.yScale = GameSceneConstants.skullScaleFactor
        setupSkull()
        setupPhysics()
    }

    func setupPhysics() {
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: self.size.width*GameSceneConstants.gameItemPhysicsRadius)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Skull
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
    }
    func setupSkull() {
        skullTextures = setupTextures("Skull")
        skullAnimation = SKAction.animate(with: skullTextures, timePerFrame: GameSceneConstants.skullAnimationTimePerFrame)
        let forever = SKAction.repeat(skullAnimation, count: -1)
        self.run(forever)

    }

}
