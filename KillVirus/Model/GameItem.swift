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
    var pointValue:Int = 0
    
    convenience init(type:GameItemType, sprite:SKSpriteNode?)
    {
           self.init()
           self.itemType = type
           self.itemSprite = sprite
    }

}


