//
//  Coin.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 1/17/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit


final class Coin: SKSpriteNode {
    
    var pointValue:UInt = 0
 
    convenience init(_ coinType: GameItemType)
    {
        if(coinType == GameItemType.silverCoin)
        {
            self.init(imageNamed:"SilverCoinUpright")
            self.pointValue = GameSceneConstants.pointValueSilverPiece
        }
        else if(coinType == GameItemType.goldCoin)
        {
            self.init(imageNamed:"GoldCoinUpright")
            self.pointValue = GameSceneConstants.pointValueGoldPiece
        }
        else
        {
            self.init()
        }
        self.xScale = GameSceneConstants.coinXScale
        self.yScale = GameSceneConstants.coinYScale
        setupPhysics()
        
    }
    func setupPhysics()->Void
    {
        self.physicsBody = SKPhysicsBody.init(circleOfRadius:self.size.width*GameSceneConstants.gameItemPhysicsRadius)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Coin
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
    }




}
