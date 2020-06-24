//
//  Labels.swift
//  KillVirus
//
//  Created by Jeremy Bringetto on 5/17/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//
import Foundation
import SpriteKit


final class  HealthMeter:SKSpriteNode
{
    let maximumWidth:CGFloat = 80.0
    let grayBar = SKSpriteNode(color: UIColor.gray, size: CGSize(width: 80.0, height: 15.0))
    let greenBar = SKSpriteNode(color: UIColor.green, size: CGSize(width: 80.0, height: 15.0))
    let healthLabel = SKLabelNode(fontNamed: "Arial-Bold")
    let padding:CGFloat = 10.0

    
    func setup()->Void
    {
        self.removeAllChildren()
        self.addChild(grayBar)
        self.addChild(greenBar)
        healthLabel.fontSize = 16.0
        healthLabel.fontColor = UIColor.white
        healthLabel.text = "H E A L T H"
        healthLabel.position = CGPoint(x: -1.0, y: 12.0)
        self.addChild(healthLabel)
    }
    func updateGreenBar(_ healthPoints:UInt, _ maxPoints:UInt)->Void
    {
        let fraction = CGFloat(healthPoints)/CGFloat(maxPoints)
        let newWidth = maximumWidth*fraction
        greenBar.size = CGSize(width: newWidth, height: greenBar.size.height)
        let delta = (newWidth - maximumWidth)*0.5
        greenBar.position = CGPoint(x: delta, y: greenBar.position.y)
        
    }
    
}


