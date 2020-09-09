//
//  ForceField.swift
//  KillVirus
//
//  Created by Jeremy Bringetto on 8/23/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import SpriteKit

protocol ForceFieldDelegate:class {
    
    func forceFieldCountdownComplete()->Void
}


final class ForceField:SKSpriteNode
{
    weak var delegate:ForceFieldDelegate?
    var forceFieldTextures = [SKTexture]()
    var forceFieldAnimation = SKAction()
    var forceFieldForever = SKAction()
    let forceFieldKey =  "forceFieldForever"
    var countdownLabel = SKLabelNode()
    var timer:Int = 1800
    let frameRate:Int = 60
    
    convenience init()
    {
        self.init(imageNamed:"ForceField0001")
        addTexturesAndScale()
        setupAnimation(timePerFrame: 0.1)
        addCountdownLabel()
     
    }
    private func addTexturesAndScale()->Void
    {
        forceFieldTextures = setupTextures("ForceField")
        self.xScale = GameSceneConstants.forceFieldScaleConstant
        self.yScale = GameSceneConstants.forceFieldScaleConstant
    }
    private func addCountdownLabel()->Void
    {
        countdownLabel.fontSize = 48
        countdownLabel.fontColor = UIColor.white
        countdownLabel.position = CGPoint(x: 0.0, y: 60.0)
        self.addChild(countdownLabel)
    }
    private func setupAnimation(timePerFrame:TimeInterval)->Void
    {
        forceFieldAnimation = SKAction.animate(with: forceFieldTextures, timePerFrame:timePerFrame)
        forceFieldForever = SKAction.repeat(forceFieldAnimation,count: -1)
        self.run(forceFieldForever, withKey: forceFieldKey)

    }
    func timerCountDown()->Void
    {
        timer -= 1
        let seconds:Int = timer / frameRate + 1
        countdownLabel.text = String(seconds)
        if(seconds == 0) {
            delegate?.forceFieldCountdownComplete()
            timer = 1800
        }
    }
    
}
