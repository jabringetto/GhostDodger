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
    private var columnHalfWidth:CGFloat = 0.0
    private var itemPositions = [CGPoint]()
    private var gameItems = [GameItem]()
    private var skulls = [Skull]()
    private var virus = [Virus]()

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
            let primaryDiceRoll = Int.random(in: 1...100)
            let secondaryDiceRoll = Int.random(in: 1...100)
            
            let type = typeForRoll(primaryDiceRoll,secondaryDiceRoll)
            let gameItem = GameItem.init(type:type, sprite: spriteForType(type))
            if let sprite = gameItem.itemSprite
            {
                sprite.position = point
                layerNode.addChild(sprite)
                if(type == GameItemType.skull)
                {
                    if let aSkull = sprite as? Skull
                    {
                        skulls.append(aSkull)
                    }
                }
                if(type == GameItemType.virus)
                {
                      if let aVirus = sprite as? Virus
                      {
                        virus.append(aVirus)
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
            
        case GameItemType.virus:
            return Virus.init(type)
            
        default:
            return nil
        }
    }
    private func typeForRoll(_ primaryRoll:Int, _ secondaryRoll:Int)->GameItemType
    {
        var type = GameItemType.none
        if(primaryRoll > 90 && primaryRoll <= 100)
        {
            type = .virus
        }
        else if (primaryRoll > 80 && primaryRoll <= 90)
        {
            type = secondaryTypeForRoll(secondaryRoll)
        }
        return type
        
    }
    private func secondaryTypeForRoll(_ diceRoll:Int)->GameItemType
    {
           var type = GameItemType.none
           if(diceRoll > 98)
           {
               type = .ruby
           }
           if(diceRoll > 96 && diceRoll <= 98 )
           {
             type = .emerald
           }
           if(diceRoll > 88 && diceRoll <= 96)
           {
               type = .silverCoin
           }
           if(diceRoll > 85 && diceRoll <= 88)
           {
            type = .goldCoin
           }
           if(diceRoll == 85)
           {
            type = .skull
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
    func spritesFollowPlayerEveryFrame(_ layerPosition:CGPoint, _ targetPosition:CGPoint, _ followSpeed:CGFloat)->Void
    {
        for skull in skulls
        {

            skull.followPointWithinYRange(layerPosition, targetPosition, followSpeed, yRange: GameSceneConstants.skullFollowRange)
            
        }
        for aVirus in virus
        {
            aVirus.followPointWithinYRange(layerPosition, targetPosition, followSpeed * 0.5 * aVirus.randomFollowFactor, yRange: GameSceneConstants.skullFollowRange * 0.5 * aVirus.randomFollowFactor)
        }
       
        
    }
    
    
}
