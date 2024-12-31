//
//  LayoutManager.swift
//  GhostDodger
//
//  Created by Jeremy Bringetto on 12/30/24.
//  Copyright © 2024 Jeremy Bringetto. All rights reserved.
//

import SpriteKit

protocol LayoutManager {
    func setupScene(_ scene: SKScene)
    func addBackground(_ scene: SKScene)
}

final class EnterSceneLayoutManager: LayoutManager {
    func setupScene(_ scene: SKScene) {
        guard let enterScene = scene as? EnterScene else { return }
        
        // Add layers first with proper z-positions
        enterScene.sceneVars.background.zPosition = -10  // Background at back
        enterScene.sceneVars.conveyorLayer.zPosition = 0 // Conveyor layer in middle
        enterScene.sceneVars.letterLayer.zPosition = 10  // Letter layer in front
        
        // Add nodes to scene in order
        addBackground(enterScene)
        enterScene.addChild(enterScene.sceneVars.conveyorLayer)  // Add conveyor layer to scene
        enterScene.addChild(enterScene.sceneVars.letterLayer)    // Add letter layer to scene
        
        // Add sprites to appropriate layers
        addLetters(enterScene)
        addEnterBat(enterScene)
        addEnterGhost(enterScene)
        addEnterRuby(enterScene)
        addEnterCoins(enterScene)
        addEnterSkull(enterScene)
    }
    
    func addBackground(_ scene: SKScene) {
        guard let enterScene = scene as? EnterScene else { return }
        enterScene.sceneVars.background.size.width = enterScene.sceneVars.screenWidth
        enterScene.sceneVars.background.size.height = enterScene.sceneVars.screenHeight
        enterScene.addChild(enterScene.sceneVars.background)
    }
    
    func addLetters(_ scene: EnterScene) {
        // Set z-positions for letters if needed
        for letter in scene.sceneVars.virusLetters {
            letter.zPosition = 2  // Ensure letters are visible within letter layer
            scene.sceneVars.letterLayer.addChild(letter)
        }
    }
    
    func addEnterBat(_ scene: EnterScene) {
        scene.sceneVars.enterBat.xScale = EnterSceneConstants.enterBatScale
        scene.sceneVars.enterBat.yScale = EnterSceneConstants.enterBatScale
        scene.sceneVars.enterBat.position.x = EnterSceneConstants.conveyorSpacing
        scene.sceneVars.enterBat.zPosition = 1  // Ensure bat is visible within conveyor layer
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterBat)
    }
    
    func addEnterGhost(_ scene: EnterScene) {
        scene.sceneVars.enterGhost.xScale = EnterSceneConstants.enterBatScale
        scene.sceneVars.enterGhost.yScale = EnterSceneConstants.enterBatScale
        scene.sceneVars.enterGhost.zPosition = 1
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterGhost)
    }
    
    func addEnterRuby(_ scene: EnterScene) {
        scene.sceneVars.enterRuby.xScale = EnterSceneConstants.enterRubyScale
        scene.sceneVars.enterRuby.yScale = EnterSceneConstants.enterRubyScale
        scene.sceneVars.enterRuby.position.x = EnterSceneConstants.conveyorSpacing * 2.0
        scene.sceneVars.enterRuby.spinSlowly()
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterRuby)
    }
    
    func addEnterCoins(_ scene: EnterScene) {
        scene.sceneVars.enterGoldCoin.xScale = EnterSceneConstants.enterCoinScale
        scene.sceneVars.enterGoldCoin.yScale = EnterSceneConstants.enterCoinScale
        scene.sceneVars.enterGoldCoin.position.x = EnterSceneConstants.conveyorSpacing * 2.6
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterGoldCoin)
        
        scene.sceneVars.enterSilverCoin.xScale = EnterSceneConstants.enterCoinScale
        scene.sceneVars.enterSilverCoin.yScale = EnterSceneConstants.enterCoinScale
        scene.sceneVars.enterSilverCoin.position.x = EnterSceneConstants.conveyorSpacing * 3.0
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterSilverCoin)
    }
    
    func addEnterSkull(_ scene: EnterScene) {
        scene.sceneVars.enterSkull.xScale = 1.0
        scene.sceneVars.enterSkull.yScale = 1.0
        scene.sceneVars.enterSkull.position.x = EnterSceneConstants.conveyorSpacing * 4.0
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterSkull)
    }
    
    func setLetterPositions(_ scene: EnterScene, width: CGFloat, height: CGFloat) {
        scene.sceneVars.letterD.position.x = width * 0.6
        scene.sceneVars.letterO.position.x = width * 0.82
        scene.sceneVars.lowercaseLetterD.position.x = width * 1.0
        scene.sceneVars.letterG.position.x = width * 1.12
        scene.sceneVars.letterE.position.x = width * 1.28
        scene.sceneVars.lowercaseLetterR.position.x = width * 1.4
        
        scene.sceneVars.virusLetters.append(scene.sceneVars.letterD)
        scene.sceneVars.virusLetters.append(scene.sceneVars.letterO)
        scene.sceneVars.virusLetters.append(scene.sceneVars.lowercaseLetterD)
        scene.sceneVars.virusLetters.append(scene.sceneVars.letterG)
        scene.sceneVars.virusLetters.append(scene.sceneVars.letterE)
        scene.sceneVars.virusLetters.append(scene.sceneVars.lowercaseLetterR)
        
        for letter in scene.sceneVars.virusLetters {
            centerLetterVertically(letter: letter, scene: scene)
            letter.xScale = EnterSceneConstants.enterLettersScale
            letter.yScale = EnterSceneConstants.enterLettersScale
        }
        
        scene.sceneVars.letterG.position.y -= scene.sceneVars.letterG.size.height * 0.5
    }
    
    private func centerLetterVertically(letter: SKSpriteNode, scene: EnterScene) {
        letter.position.y = scene.sceneVars.screenHeight * 0.20 + (letter.size.height * 0.5)
    }
}

final class GameSceneLayoutManager: LayoutManager {
    func setupScene(_ scene: SKScene) {
        guard let gameScene = scene as? GameScene else { return }
        gameScene.uptakePersistentValues()
        addBackground(gameScene)
        addBackLayer(gameScene)
        addBlackBar(gameScene)
        addScoreLabel(gameScene)
        addRoundLabel(gameScene)
        addPauseButton(gameScene)
        addHealthMeter(gameScene)
        addUpgradesButton(gameScene)
        addCycloneDashboardIndicator(gameScene)
        addForceFieldDashboardIndicator(gameScene)
        setupGrid(gameScene)
        addBat(gameScene)
        restoreForceField(gameScene)
        restoreCyclone(gameScene)
        addGameOver(gameScene)
        addCountdownAnnouncer(gameScene)
        addRoundCompletedAnnouncer(gameScene)
    }
    
    func addBackground(_ scene: SKScene) {
        guard let gameScene = scene as? GameScene else { return }
        gameScene.varsInitialValues.screenWidth = gameScene.gameVars.screenWidth
        gameScene.varsInitialValues.screenHeight = gameScene.gameVars.screenHeight
        gameScene.gameVars.background.size.width = gameScene.gameVars.screenWidth
        gameScene.gameVars.background.size.height = gameScene.gameVars.screenHeight
        gameScene.addChild(gameScene.gameVars.background)
    }
    
    func addBackLayer(_ scene: GameScene) {
        scene.addChild(scene.gameVars.backLayer)
    }
    
    func addBlackBar(_ scene: GameScene) {
        scene.gameVars.blackBar.size = CGSize(width: scene.gameVars.screenWidth, height: GameSceneConstants.blackBarHeight)
        let offset = scene.gameVars.screenHeight / 2.0 - GameSceneConstants.blackBarHeight * 0.5
        let blackBarYPos = GameSceneConstants.gameSceneBottomPadding - offset
        scene.gameVars.blackBar.position = CGPoint(x: 0.0, y: blackBarYPos)
        scene.gameVars.blackBar.alpha = GameSceneConstants.blackBarAlpha
        scene.gameVars.blackBar.name = "blackBar"
        scene.addChild(scene.gameVars.blackBar)
    }
    
    func addBat(_ scene: GameScene) {
        scene.gameVars.bat.alpha = 1.0
        
        if let batPosX = scene.fetchPersistentValue(key: "batPositionX") as? CGFloat,
           let batPosY = scene.fetchPersistentValue(key: "batPositionY") as? CGFloat {
            scene.gameVars.bat.position.x = batPosX
            scene.gameVars.bat.position.y = batPosY
        } else {
            scene.gameVars.bat.position = CGPoint(x: 0.0,
                                          y: scene.gameVars.screenHeight * GameSceneConstants.batVerticalPositionMultiplier)
        }
        
        scene.addChild(scene.gameVars.bat)
        scene.addBatDelegate()
    }
    
    func restoreForceField(_ scene: GameScene) {
        if scene.gameVars.forceFieldDeployed {
            scene.gameVars.forceField.position = scene.gameVars.bat.position
            scene.gameVars.forceField.delegate = scene
            scene.addChild(scene.gameVars.forceField)
        }
    }
    
    func restoreCyclone(_ scene: GameScene) {
        if scene.gameVars.cycloneDeployed {
            scene.gameVars.cyclone.position = scene.gameVars.bat.position
            scene.gameVars.cyclone.position.y -= GameSceneConstants.cyclonePositionDelta
            scene.gameVars.cyclone.delegate = scene
            scene.addChild(scene.gameVars.cyclone)
        }
    }
    
    func setupGrid(_ scene: GameScene) {
        scene.gameVars.grid = Grid(scene.gameVars.screenWidth, scene.gameVars.screenHeight)
        scene.gameVars.grid.delegate = scene
        scene.gameVars.grid.updateGhostAndSkullOccurence()
        scene.gameVars.grid.populateGridItems(scene.gameVars.backLayer)
    }
    
    func addGameOver(_ scene: GameScene) {
        scene.gameVars.gameOver.size = announcerSize(scene)
        scene.gameVars.gameOver.position.y = GameSceneConstants.gameOverInitialPosition
        scene.gameVars.gameOver.isHidden = true
        scene.gameVars.gameOver.name = "gameOver"
        scene.gameVars.backLayer.addChild(scene.gameVars.gameOver)
    }
    
    func addCountdownAnnouncer(_ scene: GameScene) {
        scene.gameVars.countdownAnnouncer.size = announcerSize(scene)
        scene.gameVars.countdownAnnouncer.configureLabels(roundNum: scene.gameVars.round, gameInProgress: scene.gameVars.gameInProgress)
        scene.gameVars.countdownAnnouncer.position.y = -scene.gameVars.backLayer.position.y
        scene.gameVars.backLayer.addChild(scene.gameVars.countdownAnnouncer)
    }
    
    func addRoundCompletedAnnouncer(_ scene: GameScene) {
        scene.gameVars.roundCompleteAnnouncer.size = announcerSize(scene)
        let lastRowYPos: CGFloat = -CGFloat(GameSceneConstants.gridNumRows) * GameSceneConstants.gridColumnHeight
        scene.gameVars.roundEndPosition = lastRowYPos - announcerSize(scene).height * 2.0
        scene.gameVars.roundCompleteAnnouncer.position.y = scene.gameVars.roundEndPosition
        scene.gameVars.roundCompleteAnnouncer.delegate = scene
        scene.gameVars.roundCompleteAnnouncer.setCompletedLabelText()
        scene.gameVars.backLayer.addChild(scene.gameVars.roundCompleteAnnouncer)
    }
    
    func addScoreLabel(_ scene: GameScene) {
        let offset = scene.gameVars.screenHeight / 2.0 - GameSceneConstants.scoreLabelPadding
        let scoreLabelYPos = GameSceneConstants.gameSceneBottomPadding - offset
        scene.gameVars.scoreLabel = SKLabelNode(fontNamed: "Arial-Bold")
        scene.gameVars.scoreLabel.fontSize = GameSceneConstants.menuLabelFontSize
        scene.gameVars.scoreLabel.text = GameSceneConstants.scoreLabelPrefix + String(scene.gameVars.score)
        scene.gameVars.scoreLabel.position = CGPoint(x: GameSceneConstants.gameSceneHorizontalPadding, y: scoreLabelYPos)
        scene.addChild(scene.gameVars.scoreLabel)
    }
    
    func addRoundLabel(_ scene: GameScene) {
        scene.gameVars.roundLabel = SKLabelNode(fontNamed: "Arial-Bold")
        scene.gameVars.roundLabel.fontSize = GameSceneConstants.menuLabelFontSize
        scene.gameVars.roundLabel.text = GameSceneConstants.roundLabelPrefix + String(scene.gameVars.round)
        let offset = scene.gameVars.screenHeight / 2.0 - GameSceneConstants.roundLabelPadding
        scene.gameVars.roundLabel.position = CGPoint(x: -20.0, y: GameSceneConstants.gameSceneBottomPadding - offset)
        scene.addChild(scene.gameVars.roundLabel)
    }
    
    func addPauseButton(_ scene: GameScene) {
        let pauseButtonX = scene.gameVars.screenWidth / 2.0 - GameSceneConstants.healthMeterPadding * 0.5
        let offset = scene.gameVars.screenHeight / 2.0 - GameSceneConstants.roundLabelPadding
        let pauseButtonY = GameSceneConstants.gameSceneBottomPadding - offset
        scene.gameVars.pauseButton.position = CGPoint(x: pauseButtonX, y: pauseButtonY)
        scene.gameVars.pauseButton.name = "pauseButton"
        scene.gameVars.pauseButton.isHidden = true
        scene.addChild(scene.gameVars.pauseButton)
    }
    
    func addHealthMeter(_ scene: GameScene) {
        scene.gameVars.healthMeter.setup()
        let healthMeterXPos = -scene.gameVars.screenWidth / 2.0 + GameSceneConstants.healthMeterPadding
        let offset = scene.gameVars.screenHeight / 2.0 - GameSceneConstants.healthMeterPadding
        let healthMeterYPos = GameSceneConstants.gameSceneBottomPadding - offset
        scene.gameVars.healthMeter.position = CGPoint(x: healthMeterXPos, y: healthMeterYPos)
        scene.gameVars.healthMeter.updateGreenBar(scene.gameVars.bat.healthPoints, GameSceneConstants.batMaxHealthPoints)
        scene.addChild(scene.gameVars.healthMeter)
    }
    
    func addUpgradesButton(_ scene: GameScene) {
        let upgradebuttonX: CGFloat = scene.gameVars.scoreLabel.position.x
        scene.gameVars.upgradeButton.position = CGPoint(x: upgradebuttonX, y: scene.gameVars.healthMeter.position.y - 27.5)
        scene.gameVars.upgradeButton.isHidden = true
        scene.gameVars.upgradeButton.name = "upgradesButton"
        scene.addChild(scene.gameVars.upgradeButton)
    }
    
    func addCycloneDashboardIndicator(_ scene: GameScene) {
        let cycloneDashboardX: CGFloat = scene.gameVars.screenWidth * 0.20
        let cycloneDashboardY: CGFloat = scene.gameVars.roundLabel.position.y + 0.0
        scene.gameVars.cycloneDashboard.setup(cycloneReserve: scene.gameVars.cycloneReserve)
        scene.gameVars.cycloneDashboard.position = CGPoint(x: cycloneDashboardX, y: cycloneDashboardY)
        scene.gameVars.cycloneDashboard.name = "cycloneDashboardIndicator"
        scene.gameVars.cycloneDashboard.isHidden = true
        scene.addChild(scene.gameVars.cycloneDashboard)
    }
    
    func addForceFieldDashboardIndicator(_ scene: GameScene) {
        let forceFieldDashboardX: CGFloat = scene.gameVars.screenWidth * 0.20
        let forceFieldDashboardY: CGFloat = scene.gameVars.roundLabel.position.y - 30.0
        scene.gameVars.forceFieldDashboard.setup(forceFieldReserve: scene.gameVars.forceFieldReserve)
        scene.gameVars.forceFieldDashboard.position = CGPoint(x: forceFieldDashboardX, y: forceFieldDashboardY)
        scene.gameVars.forceFieldDashboard.name = "forceFieldDashboardIndicator"
        scene.gameVars.forceFieldDashboard.isHidden = true
        scene.addChild(scene.gameVars.forceFieldDashboard)
    }
    
    func announcerSize(_ scene: GameScene) -> CGSize {
        let width = scene.gameVars.screenWidth * GameSceneConstants.announcerScreenWidthRatio
        let height = width * GameSceneConstants.announcerAspectRatio
        return CGSize(width: width, height: height)
    }
}
