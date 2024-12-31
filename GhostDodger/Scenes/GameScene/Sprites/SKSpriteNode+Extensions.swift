//
//  SKSpriteNode+Extensions.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 5/1/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit

extension SKSpriteNode {

    func setupTextures(_ spriteName: String) -> [SKTexture] {

        var textures = [SKTexture]()
        let atlas = SKTextureAtlas(named: spriteName)
        guard atlas.textureNames.count > 0 else {return textures}
        for index in 1...atlas.textureNames.count {
            var name: String = ""
            if index < 10 {
                name = spriteName + "000" + String(index) + ".png"
            } else {
                name = spriteName + "00" + String(index) + ".png"
            }
            let texture = atlas.textureNamed(name)
            textures.append(texture)

        }
        return textures

    }
    func convergeOnPointAndShrink(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat) {
        if self.parent != nil {
            followPoint(layerPosition, targetPosition, followSpeed)
            self.xScale *= GameSceneConstants.spriteSizeShrinkMultiplier
            self.yScale *=  GameSceneConstants.spriteSizeShrinkMultiplier
            if self.xScale < GameSceneConstants.spriteSizeShrinkThreshold {
                if let item = self as?  GameSprite {
                    if item.convergingOnCyclone {
                        item.delegate?.shrinkCompleted(sprite: item)
                        item.convergingOnCyclone = false
                    }
                }
                self.removeFromParent()
            }
        }

      }

    func convergeOnPoint(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat) {
          followPoint(layerPosition, targetPosition, followSpeed)
      }

    func followPoint(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat) {
                followPointX(layerPosition, targetPosition, followSpeed)
                followPointY(layerPosition, targetPosition, followSpeed)
    }
    func followPointX(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat) {
        if self.position.x < targetPosition.x {
                self.position.x += followSpeed
        } else if targetPosition.x <  self.position.x {
                self.position.x -= followSpeed
        }
    }
    func followPointY(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat) {

       let effectiveY = self.position.y + layerPosition.y
       let yDistance = targetPosition.y - effectiveY

       if yDistance > 0 {
           self.position.y += followSpeed
       } else {
           self.position.y -= followSpeed
       }
    }
    func followPointWithinYRange(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat, yRange: CGFloat) {
        let effectiveY = self.position.y + layerPosition.y
        let yDistance = targetPosition.y - effectiveY
        if abs(yDistance) < yRange  && yDistance > GameSceneConstants.skullFollowMarginY {
            followPoint(layerPosition, targetPosition, followSpeed)
        }

    }
    func isWithinRadiusOfTarget(_ layerPosition: CGPoint, _ targetPosition: CGPoint, radius: CGFloat) -> Bool {
        let effectiveY = self.position.y + layerPosition.y
        let yDistance = targetPosition.y - effectiveY
        let xDistance = targetPosition.x - self.position.x
        let distanceSquared = (xDistance * xDistance) + (yDistance * yDistance)
        let distance = sqrt(distanceSquared)
        return distance < radius
    }
    func followPointWithinRadius(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat, radius: CGFloat) {
        let effectiveY = self.position.y + layerPosition.y
        let yDistance = targetPosition.y - effectiveY
        let xDistance = targetPosition.x - self.position.x
        let distanceSquared = (xDistance * xDistance) + (yDistance * yDistance)
        let distance = sqrt(distanceSquared)
        if distance < radius {
            self.followPoint(layerPosition, targetPosition, followSpeed)

        }

    }

}
