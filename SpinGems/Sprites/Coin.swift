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
    
    let coinXScale:CGFloat = 0.3
    let coinYScale:CGFloat = 0.2
    
    convenience init(_ coinType: GameItemType)
    {
        if(coinType == GameItemType.silverCoin)
        {
             self.init(imageNamed:"SilverCoinUpright")
        }
        else if(coinType == GameItemType.goldCoin)
        {
             self.init(imageNamed:"GoldCoinUpright")
        }
        else
        {
            self.init()
        }
        self.xScale = coinXScale
        self.yScale = coinYScale
        setupPhysics()
        
    }
    func setupPhysics()->Void
    {
        self.physicsBody = SKPhysicsBody.init(circleOfRadius:self.size.width*0.4)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Coin
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bat
    }




}
