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
}
class EnterScene: SKScene
{

    var sceneVars = EnterSceneVars()
    
    override func didMove(to view: SKView)
    {
        sceneVars.virusWithFace = VirusWithFace.init(GameItemType.virus)
        sceneVars.virusWithFace.position = CGPoint(x: self.frame.midX + 10.0, y: self.frame.midY + 100.0)
        self.addChild(sceneVars.virusWithFace)
    }
}
