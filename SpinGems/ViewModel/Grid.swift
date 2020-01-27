//
//  Grid.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 1/16/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


final class Grid
{
    var columnHalfWidth:CGFloat = 0.0
    var itemPositions = [CGPoint]()
    var gameItems = [GameItem]()
    var skulls = [Skull]()
    private var convergingSprites = [String:SKSpriteNode]()
    
    convenience init(_ width:CGFloat, _ height:CGFloat)
    {
        self.init()
        columnHalfWidth = width / 12.0
        populatePositions()
    }
    func populatePositions()->Void
    {
        for i:Int in 0..<GameSceneConstants.gridNumColumns
        {
            let columnFactor =  2 * CGFloat(i - GameSceneConstants.gridNumColumns/2)
            let xPos:CGFloat = (1 + columnFactor)  * columnHalfWidth
            
            for j:Int in 0..<GameSceneConstants.gridNumRows
            {
                let yPos:CGFloat = -1.0 * CGFloat(j) * GameSceneConstants.gridColumnHeight
                let itemPosition = CGPoint(x:xPos, y:yPos)
                itemPositions.append(itemPosition)
            }
        }
    }
    func populateGridItems(_ layerNode:SKNode)->Void
    {
        for point:CGPoint in itemPositions
        {
            let percentileDiceRoll = Int.random(in: 1...100)
            let type = itemTypeForRoll(percentileDiceRoll)
            let gameItem = GameItem.init(type:type, sprite: spriteForType(type))
            if let sprite = gameItem.itemSprite
            {
                sprite.position = point
                layerNode.addChild(sprite)
                if(type == GameItemType.skull)
                {
                    if let skull = sprite as? Skull
                    {
                        skulls.append(skull)
                    }
                }
            }
        }
    }
    private func spriteForType(_ type:GameItemType)->SKSpriteNode?
    {
        switch type
        {
        case GameItemType.ruby:
            return Gem.init(type)
            
        case GameItemType.emerald:
             return Gem.init(type)
            
        case GameItemType.silverCoin:
            return Coin.init(type)
            
        case GameItemType.goldCoin:
             return Coin.init(type)
            
        case GameItemType.skull:
             return Skull.init(type)
            
        default:
            return nil
        }
    }
    private func itemTypeForRoll(_ diceRoll:Int)->GameItemType
    {
           var type = GameItemType.none
           if(diceRoll > 98)
           {
               type = GameItemType.emerald
           }
           if(diceRoll > 93 && diceRoll <= 98 )
           {
               type = GameItemType.ruby
           }
           if(diceRoll > 88 && diceRoll <= 93)
           {
               type = GameItemType.silverCoin
           }
           if(diceRoll > 85 && diceRoll <= 88)
           {
               type = GameItemType.goldCoin
           }
           if(diceRoll == 85)
           {
                type = GameItemType.skull
           }
           return type
    }
    func addConvergingSpriteForKey(sprite:SKSpriteNode, key:String )->Void
    {
        convergingSprites[key] = sprite
        
    }

    func spritesConvergeEveryFrame(_ layerPosition:CGPoint, _ targetPosition:CGPoint, _ followSpeed:CGFloat)->Void
    {
        let keys:[String] =  convergingSprites.map{$0.key}
        
        for key in keys
        {
            if let sprite = convergingSprites[key]
            {
                if(sprite.parent == nil)
                {
                    convergingSprites.removeValue(forKey:key)
                }
                else
                {
                    sprite.convergeOnPointAndShrink(layerPosition, targetPosition, followSpeed)
                }
            }
         
        }
    }
    func skullsFollowPlayerEveryFrame(_ layerPosition:CGPoint, _ targetPosition:CGPoint, _ followSpeed:CGFloat)->Void
    {
        for skull in skulls
        {
//            skull.followPointXWithinYRange(layerPosition, targetPosition, followSpeed, yRange:GameSceneConstants.skullFollowRange)
            skull.followPoint(layerPosition, targetPosition, followSpeed)
        }
       
        
    }
    
    
}
