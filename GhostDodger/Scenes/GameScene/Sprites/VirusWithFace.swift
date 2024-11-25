//
//  VirusWithFace.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 5/3/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

class VirusWithFace: SKSpriteNode {

    var virusTextures = [SKTexture]()
    var virusAnimation = SKAction()

    convenience init(_ itemType: GameItemType) {
         if itemType == GameItemType.virus {
             self.init(imageNamed: "VirusWithFace0001")
             setupTexturesAndAnimation()
         } else {
           self.init()
         }

     }
    func setupTexturesAndAnimation() {
         virusTextures = setupTextures("VirusWithFace")
        virusAnimation = SKAction.animate(with: virusTextures, timePerFrame: GameSceneConstants.virusWithFaceAnimationTimePerFrame)
         let forever = SKAction.repeat(virusAnimation, count: -1)
         self.run(forever)

     }

}
