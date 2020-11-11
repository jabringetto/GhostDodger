//
//  UpgradeScene.swift
//  KillVirus
//
//  Created by Jeremy Bringetto on 10/31/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

struct UpgradeSceneConstants
{
    static let upgradeSceneScaleMultiplier:CGFloat = 0.7
}
struct UpgradeSceneVars
{
    var forceField = ForceField()
    var cyclone = Cyclone()
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    var batSpacing:CGFloat = 0.0
    var background = SKSpriteNode(imageNamed:"Background_NoBranches")
    var forceFieldBat = Bat()
    var cycloneBat = Bat()
    var batMoveSineArgument:CGFloat = 0.0
    var cycloneDeltaY:CGFloat = 0.0
    
    mutating func setScreenDimensions(_ width:CGFloat, _ height:CGFloat)->Void
    {
        screenWidth = width
        screenHeight = height
        batSpacing = screenHeight/4.0
        cycloneDeltaY = GameSceneConstants.cyclonePositionDelta * UpgradeSceneConstants.upgradeSceneScaleMultiplier
    }
    
}

class UpgradeScene: SKScene
{
    var upgradeVars = UpgradeSceneVars()

    override func didMove(to view: SKView)
    {
        self.anchorPoint = CGPoint(x:0.5,y:0.5)
        addBackground()
        addBats()
        addForceField()
        addCyclone()
        
    }
    private func addBackground()->Void
    {
        upgradeVars.background.size.width = upgradeVars.screenWidth
        upgradeVars.background.size.height = upgradeVars.screenHeight
        upgradeVars.background.zPosition = 0.00
        
        self.addChild(upgradeVars.background)
    }
    func addBats()->Void
     {
        upgradeVars.forceFieldBat.zPosition = 0.001
        upgradeVars.forceFieldBat.position.y =  -upgradeVars.batSpacing
        upgradeVars.forceFieldBat.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.forceFieldBat.yScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        addChild(upgradeVars.forceFieldBat)
      
        upgradeVars.cycloneBat.zPosition = 0.002
        upgradeVars.cycloneBat.position.y =  upgradeVars.batSpacing
        upgradeVars.cycloneBat.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.cycloneBat.yScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.cycloneBat.flipAnimation()
        addChild(upgradeVars.cycloneBat)
     }
    func moveBatsSinusoidally()->Void
    {
        let delta:CGFloat = CGFloat.pi
        upgradeVars.batMoveSineArgument += CGFloat.pi / 180.0
        upgradeVars.forceFieldBat.position.x =  0.3 * upgradeVars.screenWidth * sin(upgradeVars.batMoveSineArgument + delta)
        upgradeVars.cycloneBat.position.x =  0.3 * upgradeVars.screenWidth * sin(upgradeVars.batMoveSineArgument)
        if(upgradeVars.batMoveSineArgument >= 2.0 * CGFloat.pi )
        {
            upgradeVars.batMoveSineArgument = 0
        }
        
    }
    fileprivate func addForceField()->Void
    {
        upgradeVars.forceField.zPosition = 0.003
        upgradeVars.forceField.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.forceField.yScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        self.addChild(upgradeVars.forceField)
        
    }
    fileprivate func addCyclone()->Void
     {
         upgradeVars.cyclone.zPosition = 0.004
         upgradeVars.cyclone.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
         upgradeVars.cyclone.yScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        self.addChild(upgradeVars.cyclone)
         
     }
    
    override func update(_ currentTime: TimeInterval) {
        
        moveBatsSinusoidally()
        upgradeVars.forceField.position = upgradeVars.forceFieldBat.position
        upgradeVars.cyclone.position.x =  upgradeVars.cycloneBat.position.x
        upgradeVars.cyclone.position.y =  upgradeVars.cycloneBat.position.y - upgradeVars.cycloneDeltaY
        
    }
    
}

