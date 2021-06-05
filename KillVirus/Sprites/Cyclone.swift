//
//  Cyclone.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 9/12/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit

protocol CycloneDelegate:AnyObject {
    
    func cycloneCountdownComplete()->Void
}

class Cyclone:SKSpriteNode {
      weak var delegate:CycloneDelegate?
      private var bigWhirlpool01 = Whirlpool(timePerFrame: 1/60.0)
      private var bigWhirlpool02 = Whirlpool(timePerFrame: 1/60.0)
      private var smallWhirlpool = Whirlpool(timePerFrame: 1/120.0)
      var countdownLabel = SKLabelNode()
      var timer:Int = 1800
      let frameRate:Int = 60
    
    convenience init()
    {
         self.init(color: UIColor.clear, size: CGSize.zero)
         addWhirlpools()
         addCountdownLabel()
        
       
    }
    private func addWhirlpools()
    {
        smallWhirlpool.xScale *= 0.6
        smallWhirlpool.yScale *= 0.6
        smallWhirlpool.zRotation = CGFloat.pi
        bigWhirlpool02.zRotation = CGFloat.pi
        addChild(bigWhirlpool01)
        addChild(bigWhirlpool02)
        addChild(smallWhirlpool)
    }
    func timerCountDown()->Void
    {
        timer -= 1
        let seconds:Int = timer / frameRate + 1
        countdownLabel.text = String(seconds)
        if(seconds == 0) {
            delegate?.cycloneCountdownComplete()
            timer = 1800
        }
    }
    private func addCountdownLabel()->Void
    {
        countdownLabel.fontSize = 30
        countdownLabel.fontColor = UIColor.white
        countdownLabel.position = CGPoint(x: 0.0, y: -10.0)
        addChild(countdownLabel)
    }

    
    
     
    
    
}


