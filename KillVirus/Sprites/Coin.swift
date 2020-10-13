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
    var convergingOnCyclone = false
 
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
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Coin
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
    }
    func followCyclone(_ layerPosition: CGPoint, _ targetPosition: CGPoint, _ followSpeed: CGFloat, cycloneDeployed:Bool, radius: CGFloat)->Void
    {
        var cyclonePosition = targetPosition
        cyclonePosition.y -= 150.0
        let withinCycloneOuterRadius = isWithinRadiusOfTarget(layerPosition, cyclonePosition, radius: radius * 1.2)
        let withinCycloneInnerRadius = isWithinRadiusOfTarget(layerPosition, cyclonePosition, radius: radius * 0.3)
        
        if (cycloneDeployed)
        {
            if(withinCycloneOuterRadius)
            {
                followPoint(layerPosition, cyclonePosition, followSpeed * 1.5)
                if(withinCycloneInnerRadius)
                {
                              convergingOnCyclone = true
                            
                }
             
            }
        }
        if(convergingOnCyclone)
        {
            convergeOnPointAndShrink(layerPosition, cyclonePosition, speed * 0.25)
        }
 
    }




}
