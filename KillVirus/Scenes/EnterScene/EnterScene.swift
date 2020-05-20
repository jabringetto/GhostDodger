//
//  EnterScene.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 5/3/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit


struct EnterSceneVars
{
     var virusWithFace = VirusWithFace()
     var screenWidth:CGFloat = 0.0
     var screenHeight:CGFloat = 0.0
     mutating func setScreenDimensions(_ width:CGFloat, _ height:CGFloat)->Void
     {
        screenWidth = width
        screenHeight = height
     }
}
class EnterScene: SKScene
{

    var sceneVars = EnterSceneVars()
    
    override func didMove(to view: SKView)
    {
        self.anchorPoint = CGPoint(x:0.5,y:0.5)
        sceneVars.virusWithFace = VirusWithFace.init(GameItemType.virus)
       // sceneVars.virusWithFace.position = CGPoint(x: sceneVars.screenWidth / 2.0, y: sceneVars.screenHeight / 2.0) 
        self.addChild(sceneVars.virusWithFace)
    }
}
