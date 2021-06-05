//
//  Grid.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 1/16/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

protocol GridDelegate: AnyObject {
    func savePersistentValues()
    func savePersisentValue(value: Any, key: String)
    func removePersisentValue(key: String)
    func fetchPersistentValue(key: String)->Any?
    func saveGridDataPeristently(positionData: [String: PositionAndType])
    func fetchPersistentGridData() -> [PositionAndType]?
    func convergedRemovedSpriteEvent(sprite: SKSpriteNode)
}

final class Grid: ConvergeAndShrinkDelegate {
    weak var delegate: GridDelegate?
    private var columnHalfWidth: CGFloat = 0.0
    private var itemPositions = [CGPoint]()
    private var positionsAndTypes = [PositionAndType]()
    private var positionDataDict = [String: PositionAndType]()
    private var skulls = [Skull]()
    private var virus = [Virus]()
    private var coins = [Coin]()
    private var gems = [Gem]()
    private var convergingSpritesPlayer = [String: SKSpriteNode]()
    private var virusOccurenceLowerLimit: UInt = 80
    private var skullOccurenceLowerLimit: UInt = 84
    convenience init(_ width: CGFloat, _ height: CGFloat) {
        self.init()
        columnHalfWidth = width / 12.0
        updateVirusAndSkullOccurence()
        populatePositions()
    }
    func updateVirusAndSkullOccurence() {

        guard let round = self.delegate?.fetchPersistentValue(key: "round") as? UInt else {return}

        virusOccurenceLowerLimit -= (round - 1)
        skullOccurenceLowerLimit -= (round - 1)
    }
    func populatePositions() {
        for columnIndex: Int in 0..<GameSceneConstants.gridNumColumns {
            let columnFactor =  2 * CGFloat(columnIndex - GameSceneConstants.gridNumColumns/2)
            let xPos: CGFloat = (1 + columnFactor)  * columnHalfWidth

            for rowIndex: Int in 0..<GameSceneConstants.gridNumRows {
                let yPos: CGFloat = -1.0 * CGFloat(rowIndex) * GameSceneConstants.gridColumnHeight
                let itemPosition = CGPoint(x: xPos, y: yPos)
                itemPositions.append(itemPosition)
            }
        }
    }
    func populateGridItems(_ layerNode: SKNode) {
        populateGameItems()
        for element in positionsAndTypes {
            let point: CGPoint = element.position
            let type: GameItemType =  GameItemType(rawValue: element.type) ?? .none
            let gameItem = GameItem.init(type: type, sprite: spriteForType(type))
            if let sprite = gameItem.itemSprite {
                sprite.position = point
                let spriteName =  String(Float(point.x)) + "_" + String(Float(point.y))
                sprite.name = spriteName
                positionDataDict[spriteName] = element
                layerNode.addChild(sprite)
                if type == GameItemType.skull {
                    if let aSkull = sprite as? Skull {
                        skulls.append(aSkull)
                    }
                }
                if type == GameItemType.virus {
                    if let aVirus = sprite as? Virus {
                        virus.append(aVirus)
                    }
                }
                if type == GameItemType.goldCoin || type == GameItemType.silverCoin {
                    if let aCoin = sprite as? Coin {
                        aCoin.delegate = self
                        coins.append(aCoin)
                    }
                }
                if type == GameItemType.ruby || type == GameItemType.emerald {
                    if let aGem = sprite as? Gem {
                        aGem.delegate = self
                        gems.append(aGem)
                    }
                }
            }
        }
        self.delegate?.saveGridDataPeristently(positionData: positionDataDict)

    }
    func populateGameItems() {
        if let persistentPostionsAndTypes = self.delegate?.fetchPersistentGridData() {

            if persistentPostionsAndTypes.count > 0 {
                positionsAndTypes = persistentPostionsAndTypes
            }
        } else {
            for point: CGPoint in itemPositions {
                let primaryDiceRoll = Int.random(in: 1...100)
                let secondaryDiceRoll = Int.random(in: 1...100)
                let itemType = typeForRoll(primaryDiceRoll, secondaryDiceRoll)
                positionsAndTypes.append(PositionAndType(position: point, type: itemType.rawValue))

            }
        }

    }
    func removeSpriteFromPersistence(sprite: SKSpriteNode) {
        guard let spriteName = sprite.name else {return}
        positionDataDict.removeValue(forKey: spriteName)
        self.delegate?.saveGridDataPeristently(positionData: positionDataDict)
    }

    private func spriteForType(_ type: GameItemType) -> SKSpriteNode? {
        switch type {
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
    private func typeForRoll(_ primaryRoll: Int, _ secondaryRoll: Int) -> GameItemType {
        var type = GameItemType.none
        if primaryRoll > 90 && primaryRoll <= 100 {
              type = secondaryTypeForRoll(secondaryRoll)
        } else if primaryRoll > virusOccurenceLowerLimit && primaryRoll <= 90 {
            type = .virus
        }
        return type
    }
    private func secondaryTypeForRoll(_ diceRoll: Int) -> GameItemType {
           var type = GameItemType.none
           if diceRoll > 98 {
               type = .ruby
           }
           if diceRoll > 96 && diceRoll <= 98 {
             type = .emerald
           }
           if diceRoll > 88 && diceRoll <= 96 {
               type = .silverCoin
           }
           if diceRoll > 85 && diceRoll <= 88 {
            type = .goldCoin
           }
           if diceRoll > skullOccurenceLowerLimit &&  diceRoll <= 85 {
            type = .skull
           }
           return type
    }
    func addConvergingPlayerSpriteForKey(sprite: SKSpriteNode, key: String ) {
        convergingSpritesPlayer[key] = sprite
    }

    func spritesConvergeOnPlayer(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat) {
        let keys: [String] =  convergingSpritesPlayer.map {$0.key}
        for key in keys {
            if let sprite = convergingSpritesPlayer[key] {
                if sprite.parent == nil {
                    convergingSpritesPlayer.removeValue(forKey: key)
                } else {
                    sprite.convergeOnPointAndShrink(layerPosition, targetPosition, followSpeed)
                }
            }
        }
    }
    func spritesFollowPlayerEveryFrame(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat) {
        for skull in skulls {
            let range = GameSceneConstants.skullFollowRange
            skull.followPointWithinYRange(layerPosition, targetPosition, followSpeed, yRange: range)
        }
        for aVirus in virus {

            if let gameScene = self.delegate as? GameScene {
                let forceDeployed = gameScene.gameVars.forceFieldDeployed
                let cycloneDeployed = gameScene.gameVars.cycloneDeployed
                aVirus.followLikeAVirus(layerPosition, targetPosition, followSpeed, forceFieldDeployed: forceDeployed, cycloneDeployed: cycloneDeployed, radius: 90.0)

            }

        }
        for aCoin in coins {
            if let gameScene = self.delegate as? GameScene {
                aCoin.followCyclone(layerPosition, targetPosition, followSpeed, cycloneDeployed: gameScene.gameVars.cycloneDeployed, radius: 90.0)

            }
        }
        for aGem in gems {
            if let gameScene = self.delegate as? GameScene {
                    aGem.followCyclone(layerPosition, targetPosition, followSpeed, cycloneDeployed: gameScene.gameVars.cycloneDeployed, radius: 90.0)

            }
        }

    }
    // MARK: ConvergeAndShrinkDelegate
    func shrinkCompleted(sprite: SKSpriteNode) {
        self.delegate?.convergedRemovedSpriteEvent(sprite: sprite)
    }

}
