//
//  EnterScene.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 5/3/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

struct EnterSceneConstants
{
    static let conveyorSpeed:CGFloat = 0.25
    static let conveyorSpacing:CGFloat = 400.0
    static let enterBatScale:CGFloat = 1.2
    static let enterRubyScale:CGFloat = 2.0
}
struct EnterSceneVars
{
     
     var screenWidth:CGFloat = 0.0
     var screenHeight:CGFloat = 0.0
     var background = SKSpriteNode(imageNamed:"Background_NoBranches")
     var conveyorLayer = SKNode()
     var virusWithFace = VirusWithFace()
     var enterBat = Bat()
     var enterRuby = Gem.init(.ruby)
     var enterEmerald = Gem.init(.emerald)
    
     mutating func setScreenDimensions(_ width:CGFloat, _ height:CGFloat)->Void
     {
        screenWidth = width
        screenHeight = height
     }
}
class EnterScene: SKScene
{

    var sceneVars = EnterSceneVars()
    // MARK: Layout
    override func didMove(to view: SKView)
    {
        self.anchorPoint = CGPoint(x:0.5,y:0.5)
        addBackground()
        self.addChild(sceneVars.conveyorLayer)
        addEnterBat()
        addVirusWithFace()
        addEnterRuby()
       
    }
    private func addBackground()->Void
    {
    
       sceneVars.background.size.width = sceneVars.screenWidth
        sceneVars.background.size.height = sceneVars.screenHeight
        self.addChild(sceneVars.background)
    }
    private func addEnterBat()->Void
    {
       sceneVars.enterBat.xScale = EnterSceneConstants.enterBatScale
       sceneVars.enterBat.yScale = EnterSceneConstants.enterBatScale
       sceneVars.conveyorLayer.addChild(sceneVars.enterBat)
    }
    private func addVirusWithFace()->Void
    {
        sceneVars.virusWithFace = VirusWithFace.init(GameItemType.virus)
        sceneVars.virusWithFace.position.x = EnterSceneConstants.conveyorSpacing
        sceneVars.conveyorLayer.addChild(sceneVars.virusWithFace)
    }
    private func addEnterRuby()->Void
    {
        sceneVars.enterRuby.xScale = EnterSceneConstants.enterRubyScale
        sceneVars.enterRuby.yScale = EnterSceneConstants.enterRubyScale
        sceneVars.enterRuby.position.x = EnterSceneConstants.conveyorSpacing * 2.0
        sceneVars.enterRuby.spinSpeed = 1
        sceneVars.conveyorLayer.addChild(sceneVars.enterRuby)
    }
    

     // MARK: Every Frame
     override func update(_ currentTime: TimeInterval)
     {
        moveConveyorNode()
        
     }
     private func moveConveyorNode()->Void
     {
        sceneVars.conveyorLayer.position.x -= EnterSceneConstants.conveyorSpeed
     }
}
