//
//  AnnouncerCountdown.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 6/19/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//


import SpriteKit

class AnnouncerCountdown: SKSpriteNode
{
      var getReadyLabel = SKLabelNode(fontNamed: "Arial-Bold")
      var counterLabel = SKLabelNode(fontNamed: "Arial-Bold")
      init()
      {
          let texture = SKTexture(imageNamed: "Announcer")
          super.init(texture: texture, color: UIColor.clear, size: texture.size())
          
      }
      required init(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
     func updateCounterLabel(_ counter:Int)->Void
     {
        let frameRate:Int = 60
        let quotient:Int = counter/frameRate + 1
        counterLabel.text = String(quotient)
     }
      func updatelabelSize(_ scaleFactor:CGFloat)->Void
      {
          getReadyLabel.fontSize *= scaleFactor
        counterLabel.fontSize *= scaleFactor
      }
    func configureLabels(roundNum:UInt, gameInProgress:Bool)
      {
        getReadyLabel.fontColor = UIColor(hex: "#D5BF9DFF")
        getReadyLabel.fontSize = self.size.width * 0.08
        getReadyLabel.position.y = self.size.height * 0.25
        getReadyLabel.text = getReadyText(roundNum: roundNum, gameInProgress: gameInProgress)
        self.addChild(getReadyLabel)
        
        
        counterLabel.fontColor = UIColor(hex: "#340034FF")
        counterLabel.fontSize = self.size.width * 0.4
        counterLabel.position.y = self.size.height * -0.35
        self.addChild(counterLabel)
        
      }
     private func getReadyText(roundNum:UInt, gameInProgress:Bool)->String
     {
        if(gameInProgress)
        {
            return "Round \(roundNum) continues in:"
        }
        else
        {
            return "Round \(roundNum) begins in:"
        }
     }
    
    
}
