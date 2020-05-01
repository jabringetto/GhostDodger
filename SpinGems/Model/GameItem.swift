//
//  GameItem.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 1/16/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

enum GameItemType:Int
{
    case none
    
    case ruby
    
    case emerald
    
    case silverCoin
    
    case goldCoin
    
    case skull
    
    case virus
}

final class GameItem: SKNode {
    
    var itemType:GameItemType?
    var itemSprite:SKSpriteNode?

    
    convenience init(type:GameItemType, sprite:SKSpriteNode?)
    {
          
           self.init()
           self.itemType = type
           self.itemSprite = sprite
    }

}

extension SKSpriteNode
{
   
    func convergeOnPoint(_ layerPosition:CGPoint, _ targetPosition:CGPoint, _ followSpeed:CGFloat)->Void
      {
          followPoint(layerPosition, targetPosition, followSpeed)
      }
    func convergeOnPointAndShrink(_ layerPosition:CGPoint, _ targetPosition:CGPoint, _ followSpeed:CGFloat)->Void
    {
        followPoint(layerPosition, targetPosition, followSpeed)
        self.xScale *= 0.96
        self.yScale *= 0.96
        if(self.xScale < 0.1)
        {
            self.removeFromParent()
        }
    }
    func followPoint(_ layerPosition:CGPoint, _ targetPosition:CGPoint, _ followSpeed:CGFloat)->Void
    {
                followPointX(layerPosition, targetPosition, followSpeed)
                followPointY(layerPosition, targetPosition, followSpeed)
    }
    func followPointX(_ layerPosition:CGPoint, _ targetPosition:CGPoint, _ followSpeed:CGFloat)->Void
    {
        if(self.position.x < targetPosition.x)
        {
                self.position.x += followSpeed
        }
        else if (targetPosition.x <  self.position.x)
        {
                self.position.x -= followSpeed
        }
    }
    func followPointY(_ layerPosition:CGPoint, _ targetPosition:CGPoint, _ followSpeed:CGFloat)->Void
    {

       let effectiveY = self.position.y + layerPosition.y
       let yDistance = targetPosition.y - effectiveY

       if(yDistance > 0)
       {
           self.position.y += followSpeed
       }
       else
       {
           self.position.y -= followSpeed
       }
    }
    func followPointWithinYRange(_ layerPosition:CGPoint, _ targetPosition:CGPoint, _ followSpeed:CGFloat, yRange:CGFloat)->Void
    {
        let effectiveY = self.position.y + layerPosition.y
        let yDistance = targetPosition.y - effectiveY
        if(abs(yDistance) < yRange && yDistance > GameSceneConstants.skullFollowMarginY)
        {
            followPoint(layerPosition, targetPosition, followSpeed)
        }

    }
   
}

