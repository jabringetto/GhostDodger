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
    var cycloneBlackBar = SKSpriteNode()
    var forceFieldBlackBar = SKSpriteNode()
    var cycloneUpgradeTitleLabel = SKLabelNode(fontNamed: "Arial-Bold")
    var forceFieldUpgradeTitleLabel =  SKLabelNode(fontNamed: "Arial-Bold")
    var cycloneUpgradeDescLabel = SKLabelNode(fontNamed: "Arial")
    var forceFieldUpgradeDescLabel =  SKLabelNode(fontNamed: "Arial")
    var cycloneReserveLabel = SKLabelNode(fontNamed: "Arial-Bold")
    var forceFieldReserveLabel =  SKLabelNode(fontNamed: "Arial-Bold")
    var cycloneDeployButton = MenuButton()
    var forceFieldDeployButton = MenuButton()
    var cycloneBuyButton = MenuButton()
    var forceFieldBuyButton = MenuButton()
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

final class UpgradeScene: SKScene
{
    var upgradeVars = UpgradeSceneVars()
    
    override func didMove(to view: SKView)
    {
        self.anchorPoint = CGPoint(x:0.5,y:0.5)
        addBackground()
        addBats()
        addBlackBars()
        addUpgradeTitleLabels()
        addUpgradeDescriptionLabels()
        addUpgradeReserveLabels()
        addUpgradeDeployButtons()
        addUpgradeBuyButtons()
        addForceField()
        addCyclone()
        
    }
    private func addBackground()->Void
    {
        upgradeVars.background.size.width = upgradeVars.screenWidth
        upgradeVars.background.size.height = upgradeVars.screenHeight
        
        self.addChild(upgradeVars.background)
    }
    
    func addBats()->Void
    {
        upgradeVars.cycloneBat.position.y =  upgradeVars.batSpacing
        upgradeVars.cycloneBat.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.cycloneBat.yScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.cycloneBat.flipAnimation()
        addChild(upgradeVars.cycloneBat)
        
        upgradeVars.forceFieldBat.position.y =  -upgradeVars.batSpacing
        upgradeVars.forceFieldBat.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.forceFieldBat.yScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        addChild(upgradeVars.forceFieldBat)
    }
    private func addBlackBars()->Void
    {
        let barSize = CGSize(width: upgradeVars.screenWidth, height: 80.0)
        upgradeVars.cycloneBlackBar = SKSpriteNode(color: UIColor.black, size: barSize)
        upgradeVars.cycloneBlackBar.position = upgradeVars.cycloneBat.position
        upgradeVars.cycloneBlackBar.position.y = upgradeVars.cycloneBat.position.y + 90.0
        addChild(upgradeVars.cycloneBlackBar)
        
        upgradeVars.forceFieldBlackBar = SKSpriteNode(color: UIColor.black, size: barSize)
        upgradeVars.forceFieldBlackBar.position = upgradeVars.forceFieldBat.position
        upgradeVars.forceFieldBlackBar.position.y = upgradeVars.forceFieldBat.position.y + 120.0
        addChild(upgradeVars.forceFieldBlackBar)
    }
    private func addUpgradeTitleLabels()->Void
    {
        let yPosTitle =  0.25 * upgradeVars.cycloneBlackBar.size.height
        upgradeVars.cycloneUpgradeTitleLabel.fontSize = 20.0
        upgradeVars.cycloneUpgradeTitleLabel.fontColor = .white
        upgradeVars.cycloneUpgradeTitleLabel.text = "C Y C L O N E  U P G R A D E"
        
        upgradeVars.cycloneUpgradeTitleLabel.position.y = yPosTitle
        upgradeVars.cycloneBlackBar.addChild(upgradeVars.cycloneUpgradeTitleLabel)
        
        upgradeVars.forceFieldUpgradeTitleLabel.fontSize = 20.0
        upgradeVars.forceFieldUpgradeTitleLabel.fontColor = .white
        upgradeVars.forceFieldUpgradeTitleLabel.text = "F O R C E  F I E L D  U P G R A D E"
        upgradeVars.forceFieldUpgradeTitleLabel.position.y = yPosTitle
        upgradeVars.forceFieldBlackBar.addChild(upgradeVars.forceFieldUpgradeTitleLabel)
        
    }
    private func addUpgradeDescriptionLabels()->Void
    {
        let yPosDesc:CGFloat =  0.0
        upgradeVars.cycloneUpgradeDescLabel.fontSize = 11.0
        upgradeVars.cycloneUpgradeDescLabel.fontColor = .white
        upgradeVars.cycloneUpgradeDescLabel.text = "Cyclone to suck down virus and treasure: 30 seconds | 800 pts/$0.99."
        upgradeVars.cycloneUpgradeDescLabel.position.y = yPosDesc
        upgradeVars.cycloneBlackBar.addChild(upgradeVars.cycloneUpgradeDescLabel)
        
        upgradeVars.forceFieldUpgradeDescLabel.fontSize = 11.0
        upgradeVars.forceFieldUpgradeDescLabel.fontColor = .white
        upgradeVars.forceFieldUpgradeDescLabel.text = "Force Field to repel all incoming virus: 30 seconds | 500 pts/$0.49."
        upgradeVars.forceFieldUpgradeDescLabel.position.y = yPosDesc
        upgradeVars.forceFieldBlackBar.addChild(upgradeVars.forceFieldUpgradeDescLabel)
        
    }
    private func addUpgradeReserveLabels()->Void
    {
        let yPosMenu =  -0.35 * upgradeVars.cycloneBlackBar.size.height
        upgradeVars.cycloneReserveLabel.fontSize = 14.0
        upgradeVars.cycloneReserveLabel.fontColor = .white
        upgradeVars.cycloneReserveLabel.text = "RESERVE: 0"
        upgradeVars.cycloneReserveLabel.position.y = yPosMenu
        upgradeVars.cycloneReserveLabel.position.x = 0.5 * (upgradeVars.cycloneReserveLabel.frame.size.width - upgradeVars.screenWidth) + 10.0
        upgradeVars.cycloneBlackBar.addChild(upgradeVars.cycloneReserveLabel)
        
        upgradeVars.forceFieldReserveLabel.fontSize = 14.0
        upgradeVars.forceFieldReserveLabel.fontColor = .white
        upgradeVars.forceFieldReserveLabel.text = "RESERVE: 0"
        upgradeVars.forceFieldReserveLabel.position.y = yPosMenu
        upgradeVars.forceFieldReserveLabel.position.x = 0.5 * (upgradeVars.forceFieldReserveLabel.frame.size.width - upgradeVars.screenWidth) + 10.0
        upgradeVars.forceFieldBlackBar.addChild(upgradeVars.forceFieldReserveLabel)
        
    }
    private func addUpgradeDeployButtons()->Void
    {
        let yPosMenu =  -0.35 * upgradeVars.cycloneBlackBar.size.height
        upgradeVars.cycloneDeployButton.setup(text: "DEPLOY", nodeName: "deployButtonCyclone")
        upgradeVars.cycloneDeployButton.position.y = yPosMenu
        upgradeVars.forceFieldDeployButton.setup(text: "DEPLOY", nodeName: "deployButtonForceField")
        upgradeVars.forceFieldDeployButton.position.y = yPosMenu
        upgradeVars.cycloneBlackBar.addChild(upgradeVars.cycloneDeployButton)
        upgradeVars.forceFieldBlackBar.addChild(upgradeVars.forceFieldDeployButton)
        
    }
    private func addUpgradeBuyButtons()->Void
    {
        let yPosMenu =  -0.35 * upgradeVars.cycloneBlackBar.size.height
        upgradeVars.cycloneBuyButton.setup(text: "BUY", nodeName: "buyButtonCyclone")
        upgradeVars.forceFieldBuyButton.setup(text: "BUY", nodeName: "buyButtonForceField")
        upgradeVars.cycloneBuyButton.position.y = yPosMenu
        upgradeVars.forceFieldBuyButton.position.y = yPosMenu
        upgradeVars.cycloneBuyButton.position.x = 0.5 * (upgradeVars.screenWidth - upgradeVars.cycloneBuyButton.frame.size.width) - 20.0
        upgradeVars.forceFieldBuyButton.position.x = 0.5 * (upgradeVars.screenWidth - upgradeVars.cycloneBuyButton.frame.size.width) - 20.0
        upgradeVars.cycloneBlackBar.addChild(upgradeVars.cycloneBuyButton)
        upgradeVars.forceFieldBlackBar.addChild(upgradeVars.forceFieldBuyButton)
        
        
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
        upgradeVars.forceField.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.forceField.yScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        self.addChild(upgradeVars.forceField)
        
    }
    fileprivate func addCyclone()->Void
    {         upgradeVars.cyclone.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
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

final class MenuButton:SKSpriteNode
{
    
    let menuLabel = SKLabelNode(fontNamed: "Arial-Bold")
    func setup(text:String, nodeName:String)->Void
    {
        menuLabel.fontSize = 14.0
        menuLabel.fontColor = UIColor(hex:"#add8ffff")
        menuLabel.text = text
        addChild(menuLabel)
        name = nodeName
    }
}

