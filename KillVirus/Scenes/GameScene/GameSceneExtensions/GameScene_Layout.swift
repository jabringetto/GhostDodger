//
//  GameScene_Layout.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 1/24/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit


extension GameScene
{
    
    func gameSetup()
    {
        
        uptakePersistentValues()
        addBackground()
        addBackLayer()
        addBlackBar()
        addScoreLabel()
        addRoundLabel()
        addPauseButton()
        addHealthMeter()
        addUpgradesButton()
        addCycloneDashboardIndicator()
        addForceFieldDashboardIndicator()
        setupGrid(gameVars.screenWidth,gameVars.screenHeight)
        addBat()
        restoreForceField()
        restoreCyclone()
        addGameOver()
        addCountdownannouncer()
        addRoundCompletedAnnouncer()
    }
    private func addBackground()->Void
    {
        varsInitialValues.screenWidth = gameVars.screenWidth
        varsInitialValues.screenHeight = gameVars.screenHeight
        gameVars.background.size.width = gameVars.screenWidth
        gameVars.background.size.height = gameVars.screenHeight
        self.addChild(gameVars.background)
    }
    func addBat()->Void
    {
        gameVars.bat.alpha = 1.0
        
        if let batPosX = fetchPersistentValue(key: "batPositionX") as? CGFloat, let batPosY = fetchPersistentValue(key: "batPositionY") as? CGFloat
        {
            gameVars.bat.position.x = batPosX
            gameVars.bat.position.y = batPosY
        }
        else
        {
            gameVars.bat.position = CGPoint(x: 0.0, y: gameVars.screenHeight * GameSceneConstants.batVerticalPositionMultiplier)
        }
        
        self.addChild(gameVars.bat)
        addBatDelegate()
    }
    private func restoreForceField()->Void
    {
        if(gameVars.forceFieldDeployed)
        {
            gameVars.forceField.position = gameVars.bat.position
            gameVars.forceField.delegate = self
            addChild(gameVars.forceField)
        }
    }
    private func restoreCyclone()->Void
    {
        if(gameVars.cycloneDeployed)
        {
            gameVars.cyclone.position = gameVars.bat.position
            gameVars.cyclone.position.y -= GameSceneConstants.cyclonePositionDelta
            gameVars.cyclone.delegate = self
            addChild(gameVars.cyclone)
            
        }
    }
    private func addBackLayer()->Void
    {
        self.addChild(gameVars.backLayer)
    }
    private func setupGrid(_ width:CGFloat, _ height: CGFloat)->Void
    {
        
        gameVars.grid = Grid.init(width,height)
        gameVars.grid.delegate = self
        gameVars.grid.updateVirusAndSkullOccurence()
        gameVars.grid.populateGridItems(gameVars.backLayer)
    }
    private func addGameOver()->Void
    {
        gameVars.gameOver.size = announcerSize()
        gameVars.gameOver.position.y = GameSceneConstants.gameOverInitialPosition
        gameVars.gameOver.isHidden = true
        gameVars.gameOver.name = "gameOver"
        gameVars.backLayer.addChild(gameVars.gameOver)
    }
    private func addCountdownannouncer()->Void
    {
        gameVars.countdownAnnouncer.size = announcerSize()
        gameVars.countdownAnnouncer.configureLabels(roundNum: gameVars.round, gameInProgress: gameVars.gameInProgress)
        gameVars.countdownAnnouncer.position.y = -gameVars.backLayer.position.y
        gameVars.backLayer.addChild(gameVars.countdownAnnouncer)
        
    }
    private func addRoundCompletedAnnouncer()->Void
    {
        gameVars.roundCompleteAnnouncer.size = announcerSize()
        let lastRowYPos:CGFloat = -CGFloat(GameSceneConstants.gridNumRows) * GameSceneConstants.gridColumnHeight
        gameVars.roundEndPosition =  lastRowYPos - announcerSize().height * 2.0
        gameVars.roundCompleteAnnouncer.position.y = gameVars.roundEndPosition
        gameVars.roundCompleteAnnouncer.delegate = self
        gameVars.roundCompleteAnnouncer.setCompletedLabelText()
        gameVars.backLayer.addChild(gameVars.roundCompleteAnnouncer)
    }
    private func announcerSize()->CGSize
    {
        let width = gameVars.screenWidth * GameSceneConstants.announcerScreenWidthRatio
        let height = width * GameSceneConstants.announcerAspectRatio
        return CGSize(width: width, height:height)
    }
    private func addBlackBar()->Void
    {
        gameVars.blackBar.size = CGSize(width: gameVars.screenWidth, height: GameSceneConstants.blackBarHeight)
        gameVars.blackBar.position = CGPoint(x: 0.0, y: -(gameVars.screenHeight / 2.0 - GameSceneConstants.blackBarHeight * 0.5))
        gameVars.blackBar.alpha = GameSceneConstants.blackBarAlpha
        gameVars.blackBar.name = "blackBar"
        self.addChild(gameVars.blackBar)
    }
    private func addHealthMeter()->Void
    {
        gameVars.healthMeter.setup()
        gameVars.healthMeter.position = CGPoint(x: -gameVars.screenWidth / 2.0 + GameSceneConstants.healthMeterPadding, y:  -(gameVars.screenHeight / 2.0 - GameSceneConstants.healthMeterPadding))
        gameVars.healthMeter.updateGreenBar(gameVars.bat.healthPoints, GameSceneConstants.batMaxHealthPoints)
        self.addChild(gameVars.healthMeter)
    }
    private func addScoreLabel()->Void
    {
        gameVars.scoreLabel = SKLabelNode(fontNamed: "Arial-Bold")
        gameVars.scoreLabel.fontSize = GameSceneConstants.menuLabelFontSize
        gameVars.scoreLabel.text = GameSceneConstants.scoreLabelPrefix + String(gameVars.score)
        gameVars.scoreLabel.position = CGPoint(x:-20.0 , y:  -(gameVars.screenHeight / 2.0 - GameSceneConstants.scoreLabelPadding))
        self.addChild( gameVars.scoreLabel)
    }
    private func addRoundLabel()->Void
    {
        gameVars.roundLabel = SKLabelNode(fontNamed: "Arial-Bold")
        gameVars.roundLabel.fontSize = GameSceneConstants.menuLabelFontSize
        gameVars.roundLabel.text = GameSceneConstants.roundLabelPrefix + String(gameVars.round)
        gameVars.roundLabel.position = CGPoint(x: -20.0 , y:  -(gameVars.screenHeight / 2.0 - GameSceneConstants.roundLabelPadding))
        self.addChild( gameVars.roundLabel)
    }
    private func addPauseButton()->Void
    {
        gameVars.pauseButton.position = CGPoint(x: gameVars.screenWidth / 2.0 - GameSceneConstants.healthMeterPadding*0.5, y: -(gameVars.screenHeight / 2.0 - GameSceneConstants.roundLabelPadding))
        gameVars.pauseButton.name = "pauseButton"
        gameVars.pauseButton.isHidden = true
        self.addChild(gameVars.pauseButton)
    }
    private func addUpgradesButton()->Void
    {
        let upgradebuttonX:CGFloat = gameVars.scoreLabel.position.x
        gameVars.upgradeButton.position = CGPoint(x: upgradebuttonX, y: gameVars.healthMeter.position.y - 27.5)
        gameVars.upgradeButton.isHidden = true
        gameVars.upgradeButton.name = "upgradesButton"
        self.addChild(gameVars.upgradeButton)
    }
    private func addCycloneDashboardIndicator()->Void
    {
        let cycloneDashboardX:CGFloat = gameVars.screenWidth * 0.20
        let cycloneDashboardY:CGFloat = gameVars.roundLabel.position.y + 0.0
        gameVars.cycloneDashboard.setup()
        gameVars.cycloneDashboard.position = CGPoint(x: cycloneDashboardX, y: cycloneDashboardY)
        addChild(gameVars.cycloneDashboard)
    }
    private func addForceFieldDashboardIndicator()->Void
    {
        let forceFieldDashboardX:CGFloat = gameVars.screenWidth * 0.20
        let forceFieldDashboardY:CGFloat = gameVars.roundLabel.position.y - 30.0
        gameVars.forceFieldDashboard.setup()
        gameVars.forceFieldDashboard.position =  CGPoint(x: forceFieldDashboardX, y: forceFieldDashboardY)
        addChild(gameVars.forceFieldDashboard)
    }
    
}


