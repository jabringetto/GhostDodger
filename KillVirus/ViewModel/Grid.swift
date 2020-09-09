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

protocol GridDelegate:class
{
    func savePersistentValues()->Void
    func savePersisentValue(value:Any, key:String)->Void
    func removePersisentValue(key:String)->Void
    func fetchPersistentValue(key:String)->Any?
    func saveGridDataPeristently(positionData:[String:PositionAndType])->Void
    func fetchPersistentGridData()->[PositionAndType]?
}


final class Grid
{
    weak var delegate:GridDelegate?
    private var columnHalfWidth:CGFloat = 0.0
    private var itemPositions = [CGPoint]()
    private var positionsAndTypes = [PositionAndType]()
    private var positionDataDict = [String:PositionAndType]()
    private var skulls = [Skull]()
    private var virus = [Virus]()
    private var convergingSprites = [String:SKSpriteNode]()
    private var virusOccurenceLowerLimit:UInt = 80
    private var skullOccurenceLowerLimit:UInt = 84
    
    
    convenience init(_ width:CGFloat, _ height:CGFloat)
    {
        self.init()
        columnHalfWidth = width / 12.0
        updateVirusAndSkullOccurence()
        populatePositions()
    }
    func updateVirusAndSkullOccurence()->Void
    {
        
        guard let round = self.delegate?.fetchPersistentValue(key:"round") as? UInt else {return}
        
        virusOccurenceLowerLimit -= (round - 1)
        skullOccurenceLowerLimit -= (round - 1)
        
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
        
        populateGameItems()
        for element in positionsAndTypes
        {
            let point:CGPoint = element.position
            let type:GameItemType =  GameItemType(rawValue:element.type) ?? .none
            let gameItem = GameItem.init(type:type, sprite: spriteForType(type))
            if let sprite = gameItem.itemSprite
            {
                
                sprite.position = point
                let spriteName =  String(Float(point.x)) + "_" + String(Float(point.y))
                sprite.name = spriteName
                positionDataDict[spriteName] = element
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
        self.delegate?.saveGridDataPeristently(positionData: positionDataDict)
        print(positionDataDict)

    }
    func populateGameItems()->Void
    {
        //if let persistentPostionsAndTypes = self.delegate?.fetchPersistentGrid() {
        if let persistentPostionsAndTypes = self.delegate?.fetchPersistentGridData(){
            
            if(persistentPostionsAndTypes.count > 0)
            {
                positionsAndTypes = persistentPostionsAndTypes
                
            }
        }
        else
        {
            for point:CGPoint in itemPositions
            {
                let primaryDiceRoll = Int.random(in: 1...100)
                let secondaryDiceRoll = Int.random(in: 1...100)
                let itemType = typeForRoll(primaryDiceRoll,secondaryDiceRoll)
                positionsAndTypes.append(PositionAndType(position:point, type:itemType.rawValue))
            
            }
        }
     
        

    }
    func removeSpriteFromPersistence(sprite:SKSpriteNode)->Void
    {
        guard let spriteName = sprite.name else {return}
        positionDataDict.removeValue(forKey: spriteName)
        self.delegate?.saveGridDataPeristently(positionData: positionDataDict)
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
              type = secondaryTypeForRoll(secondaryRoll)
        }
        else if (primaryRoll > virusOccurenceLowerLimit && primaryRoll <= 90)
        {
          
            type = .virus
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
           if(diceRoll > skullOccurenceLowerLimit &&  diceRoll <= 85)
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
            
            if let gameScene = self.delegate as? GameScene {
                aVirus.followLikeAVirus(layerPosition, targetPosition, followSpeed, forceFieldDeployed: gameScene.gameVars.forceFieldDeployed, radius: 90.0)
            }
            
            
        }
       
        
    }
    
    
}
