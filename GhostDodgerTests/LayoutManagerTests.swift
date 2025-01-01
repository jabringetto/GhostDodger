//
//  LayoutManagerTests.swift
//  Ghost DodgerTests
//
//  Created by Jeremy Bringetto on 12/30/24.
//  Copyright © 2024 Jeremy Bringetto. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Ghost_Dodger

// Mock Enter Scene Layout Manager for testing
class MockEnterSceneLayoutManager: LayoutManager {
    var setupSceneCalled = false
    var addedBackground = false
    var addedLetters = false
    var addedEnterBat = false
    var addedEnterGhost = false
    var addedEnterRuby = false
    var addedEnterCoins = false
    var addedEnterSkull = false
    
    func setupScene(_ scene: SKScene) {
        setupSceneCalled = true
        guard let enterScene = scene as? EnterScene else { return }
        
        addBackground(enterScene)
        addLetters(enterScene)
        addEnterBat(enterScene)
        addEnterGhost(enterScene)
        addEnterRuby(enterScene)
        addEnterCoins(enterScene)
        addEnterSkull(enterScene)
    }
    
    func addBackground(_ scene: SKScene) {
        addedBackground = true
        guard let enterScene = scene as? EnterScene else { return }
        enterScene.sceneVars.background.size.width = enterScene.sceneVars.screenWidth
        enterScene.sceneVars.background.size.height = enterScene.sceneVars.screenHeight
        enterScene.addChild(enterScene.sceneVars.background)
    }
    
    func addLetters(_ scene: EnterScene) {
        addedLetters = true
        for letter in scene.sceneVars.virusLetters {
            letter.zPosition = 4
            scene.sceneVars.letterLayer.addChild(letter)
        }
    }
    
    func addEnterBat(_ scene: EnterScene) {
        addedEnterBat = true
        scene.sceneVars.enterBat.xScale = EnterSceneConstants.enterBatScale
        scene.sceneVars.enterBat.yScale = EnterSceneConstants.enterBatScale
        scene.sceneVars.enterBat.position.x = EnterSceneConstants.conveyorSpacing
        scene.sceneVars.enterBat.zPosition = 1
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterBat)
    }
    
    func addEnterGhost(_ scene: EnterScene) {
        addedEnterGhost = true
        scene.sceneVars.enterGhost.xScale = EnterSceneConstants.enterBatScale
        scene.sceneVars.enterGhost.yScale = EnterSceneConstants.enterBatScale
        scene.sceneVars.enterGhost.zPosition = 1
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterGhost)
    }
    
    func addEnterRuby(_ scene: EnterScene) {
        addedEnterRuby = true
        scene.sceneVars.enterRuby.xScale = EnterSceneConstants.enterRubyScale
        scene.sceneVars.enterRuby.yScale = EnterSceneConstants.enterRubyScale
        scene.sceneVars.enterRuby.position.x = EnterSceneConstants.conveyorSpacing * 2.0
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterRuby)
    }
    
    func addEnterCoins(_ scene: EnterScene) {
        addedEnterCoins = true
        scene.sceneVars.enterGoldCoin.xScale = EnterSceneConstants.enterCoinScale
        scene.sceneVars.enterGoldCoin.yScale = EnterSceneConstants.enterCoinScale
        scene.sceneVars.enterSilverCoin.xScale = EnterSceneConstants.enterCoinScale
        scene.sceneVars.enterSilverCoin.yScale = EnterSceneConstants.enterCoinScale
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterGoldCoin)
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterSilverCoin)
    }
    
    func addEnterSkull(_ scene: EnterScene) {
        addedEnterSkull = true
        scene.sceneVars.enterSkull.xScale = 1.0
        scene.sceneVars.enterSkull.yScale = 1.0
        scene.sceneVars.enterSkull.position.x = EnterSceneConstants.conveyorSpacing * 4.0
        scene.sceneVars.conveyorLayer.addChild(scene.sceneVars.enterSkull)
    }
}

// Mock Game Scene Layout Manager for testing
class MockGameSceneLayoutManager: LayoutManager {
    var setupSceneCalled = false
    var addedBackground = false
    var addedBackLayer = false
    var addedBat = false
    var addedScoreLabel = false
    var addedHealthMeter = false
    var addedBlackBar = false
    var addedRoundLabel = false
    var addedPauseButton = false
    var addedUpgradesButton = false
    var addedCycloneDashboard = false
    var addedForceFieldDashboard = false
    var setupGridCalled = false
    var restoredForceField = false
    var restoredCyclone = false
    var addedGameOver = false
    var addedCountdownAnnouncer = false
    var addedRoundCompletedAnnouncer = false

    func setupScene(_ scene: SKScene) {
        setupSceneCalled = true
        guard let gameScene = scene as? GameScene else { return }
        
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
        addedBackground = true
        guard let gameScene = scene as? GameScene else { return }
        gameScene.gameVars.background.size.width = gameScene.gameVars.screenWidth
        gameScene.gameVars.background.size.height = gameScene.gameVars.screenHeight
        gameScene.addChild(gameScene.gameVars.background)
    }

    func addBackLayer(_ scene: GameScene) {
        addedBackLayer = true
        scene.addChild(scene.gameVars.backLayer)
    }

    func addBat(_ scene: GameScene) {
        addedBat = true
        scene.gameVars.backLayer.addChild(scene.gameVars.bat)
    }

    func addScoreLabel(_ scene: GameScene) {
        addedScoreLabel = true
        scene.addChild(scene.gameVars.scoreLabel)
    }

    func addHealthMeter(_ scene: GameScene) {
        addedHealthMeter = true
        scene.addChild(scene.gameVars.healthMeter)
    }
    
    func addBlackBar(_ scene: GameScene) {
        addedBlackBar = true
        scene.addChild(scene.gameVars.blackBar)
    }
    
    func addRoundLabel(_ scene: GameScene) {
        addedRoundLabel = true
        scene.gameVars.roundLabel.fontSize = GameSceneConstants.menuLabelFontSize
        scene.addChild(scene.gameVars.roundLabel)
    }
    
    func addPauseButton(_ scene: GameScene) {
        addedPauseButton = true
        scene.gameVars.pauseButton.isHidden = true
        scene.addChild(scene.gameVars.pauseButton)
    }
    
    func addUpgradesButton(_ scene: GameScene) {
        addedUpgradesButton = true
        scene.gameVars.upgradeButton.isHidden = true
        scene.addChild(scene.gameVars.upgradeButton)
    }
    
    func addCycloneDashboardIndicator(_ scene: GameScene) {
        addedCycloneDashboard = true
        scene.addChild(scene.gameVars.cycloneDashboard)
    }
    
    func addForceFieldDashboardIndicator(_ scene: GameScene) {
        addedForceFieldDashboard = true
        scene.addChild(scene.gameVars.forceFieldDashboard)
    }
    
    func setupGrid(_ scene: GameScene) {
        setupGridCalled = true
        scene.gameVars.grid = Grid(scene.gameVars.screenWidth, scene.gameVars.screenHeight)
    }
    
    func restoreForceField(_ scene: GameScene) {
        restoredForceField = true
        if scene.gameVars.forceFieldDeployed {
            scene.addChild(scene.gameVars.forceField)
        }
    }
    
    func restoreCyclone(_ scene: GameScene) {
        restoredCyclone = true
        if scene.gameVars.cycloneDeployed {
            scene.addChild(scene.gameVars.cyclone)
        }
    }
}

// Unit Tests
class LayoutManagerTests: XCTestCase {
    // Enter Scene Tests
    var mockEnterManager: MockEnterSceneLayoutManager!
    var enterScene: EnterScene!
    
    // Game Scene Tests
    var mockGameManager: MockGameSceneLayoutManager!
    var gameScene: GameScene!

    override func setUp() {
        super.setUp()
        // Enter Scene Setup
        mockEnterManager = MockEnterSceneLayoutManager()
        enterScene = EnterScene()
        enterScene.sceneVars.setScreenDimensions(800, 600)
        
        // Game Scene Setup
        mockGameManager = MockGameSceneLayoutManager()
        gameScene = GameScene()
        gameScene.gameVars.setScreenDimensions(800, 600)
    }

    override func tearDown() {
        mockEnterManager = nil
        enterScene = nil
        mockGameManager = nil
        gameScene = nil
        super.tearDown()
    }

    // MARK: - Enter Scene Tests
    
    func testEnterSceneLayoutManagerSetup() {
        // Act
        mockEnterManager.setupScene(enterScene)

        // Assert
        XCTAssertTrue(mockEnterManager.setupSceneCalled)
        XCTAssertTrue(mockEnterManager.addedBackground)
        XCTAssertTrue(mockEnterManager.addedLetters)
        XCTAssertTrue(mockEnterManager.addedEnterBat)
        XCTAssertTrue(mockEnterManager.addedEnterGhost)
        XCTAssertTrue(mockEnterManager.addedEnterRuby)
        XCTAssertTrue(mockEnterManager.addedEnterCoins)
        XCTAssertTrue(mockEnterManager.addedEnterSkull)
    }

    func testAddEnterBat() {
        // Act
        mockEnterManager.addEnterBat(enterScene)

        // Assert
        XCTAssertTrue(mockEnterManager.addedEnterBat)
        XCTAssertEqual(enterScene.sceneVars.enterBat.xScale, EnterSceneConstants.enterBatScale)
        XCTAssertEqual(enterScene.sceneVars.enterBat.yScale, EnterSceneConstants.enterBatScale)
        XCTAssertEqual(enterScene.sceneVars.enterBat.zPosition, 1)
        XCTAssertEqual(enterScene.sceneVars.enterBat.parent, enterScene.sceneVars.conveyorLayer)
    }

    func testAddEnterGhost() {
        // Act
        mockEnterManager.addEnterGhost(enterScene)

        // Assert
        XCTAssertTrue(mockEnterManager.addedEnterGhost)
        XCTAssertEqual(enterScene.sceneVars.enterGhost.xScale, EnterSceneConstants.enterBatScale)
        XCTAssertEqual(enterScene.sceneVars.enterGhost.yScale, EnterSceneConstants.enterBatScale)
        XCTAssertEqual(enterScene.sceneVars.enterGhost.parent, enterScene.sceneVars.conveyorLayer)
    }

    func testAddEnterRuby() {
        // Act
        mockEnterManager.addEnterRuby(enterScene)

        // Assert
        XCTAssertTrue(mockEnterManager.addedEnterRuby)
        XCTAssertEqual(enterScene.sceneVars.enterRuby.xScale, EnterSceneConstants.enterRubyScale)
        XCTAssertEqual(enterScene.sceneVars.enterRuby.yScale, EnterSceneConstants.enterRubyScale)
        XCTAssertEqual(enterScene.sceneVars.enterRuby.parent, enterScene.sceneVars.conveyorLayer)
    }

    func testAddEnterCoins() {
        // Act
        mockEnterManager.addEnterCoins(enterScene)

        // Assert
        XCTAssertTrue(mockEnterManager.addedEnterCoins)
        XCTAssertEqual(enterScene.sceneVars.enterGoldCoin.xScale, EnterSceneConstants.enterCoinScale)
        XCTAssertEqual(enterScene.sceneVars.enterSilverCoin.xScale, EnterSceneConstants.enterCoinScale)
        XCTAssertEqual(enterScene.sceneVars.enterGoldCoin.parent, enterScene.sceneVars.conveyorLayer)
        XCTAssertEqual(enterScene.sceneVars.enterSilverCoin.parent, enterScene.sceneVars.conveyorLayer)
    }

    func testAddEnterSkull() {
        // Act
        mockEnterManager.addEnterSkull(enterScene)

        // Assert
        XCTAssertTrue(mockEnterManager.addedEnterSkull)
        XCTAssertEqual(enterScene.sceneVars.enterSkull.xScale, 1.0)
        XCTAssertEqual(enterScene.sceneVars.enterSkull.yScale, 1.0)
        XCTAssertEqual(enterScene.sceneVars.enterSkull.parent, enterScene.sceneVars.conveyorLayer)
    }

    // MARK: - Game Scene Tests
    
    func testGameSceneLayoutManagerSetup() {
        // Act
        mockGameManager.setupScene(gameScene)

        // Assert
        XCTAssertTrue(mockGameManager.setupSceneCalled)
        XCTAssertTrue(mockGameManager.addedBackground)
        XCTAssertTrue(mockGameManager.addedBackLayer)
        XCTAssertTrue(mockGameManager.addedBlackBar)
        XCTAssertTrue(mockGameManager.addedScoreLabel)
        XCTAssertTrue(mockGameManager.addedRoundLabel)
        XCTAssertTrue(mockGameManager.addedPauseButton)
        XCTAssertTrue(mockGameManager.addedHealthMeter)
        XCTAssertTrue(mockGameManager.addedUpgradesButton)
        XCTAssertTrue(mockGameManager.addedCycloneDashboard)
        XCTAssertTrue(mockGameManager.addedForceFieldDashboard)
        XCTAssertTrue(mockGameManager.setupGridCalled)
        XCTAssertTrue(mockGameManager.addedBat)
        XCTAssertTrue(mockGameManager.restoredForceField)
        XCTAssertTrue(mockGameManager.restoredCyclone)
    }

    func testAddBlackBar() {
        // Act
        mockGameManager.addBlackBar(gameScene)

        // Assert
        XCTAssertTrue(mockGameManager.addedBlackBar)
        XCTAssertEqual(gameScene.gameVars.blackBar.parent, gameScene)
    }

    func testAddRoundLabel() {
        // Act
        mockGameManager.addRoundLabel(gameScene)

        // Assert
        XCTAssertTrue(mockGameManager.addedRoundLabel)
        XCTAssertEqual(gameScene.gameVars.roundLabel.parent, gameScene)
        XCTAssertEqual(gameScene.gameVars.roundLabel.fontSize, GameSceneConstants.menuLabelFontSize)
    }

    func testAddPauseButton() {
        // Act
        mockGameManager.addPauseButton(gameScene)

        // Assert
        XCTAssertTrue(mockGameManager.addedPauseButton)
        XCTAssertEqual(gameScene.gameVars.pauseButton.parent, gameScene)
        XCTAssertTrue(gameScene.gameVars.pauseButton.isHidden)
    }

    func testAddUpgradesButton() {
        // Act
        mockGameManager.addUpgradesButton(gameScene)

        // Assert
        XCTAssertTrue(mockGameManager.addedUpgradesButton)
        XCTAssertEqual(gameScene.gameVars.upgradeButton.parent, gameScene)
        XCTAssertTrue(gameScene.gameVars.upgradeButton.isHidden)
    }

    func testSetupGrid() {
        // Act
        mockGameManager.setupGrid(gameScene)

        // Assert
        XCTAssertTrue(mockGameManager.setupGridCalled)
        XCTAssertNotNil(gameScene.gameVars.grid)
    }

    func testRestoreForceField() {
        // Arrange
        gameScene.gameVars.forceFieldDeployed = true

        // Act
        mockGameManager.restoreForceField(gameScene)

        // Assert
        XCTAssertTrue(mockGameManager.restoredForceField)
        XCTAssertEqual(gameScene.gameVars.forceField.parent, gameScene)
    }

    func testRestoreCyclone() {
        // Arrange
        gameScene.gameVars.cycloneDeployed = true

        // Act
        mockGameManager.restoreCyclone(gameScene)

        // Assert
        XCTAssertTrue(mockGameManager.restoredCyclone)
        XCTAssertEqual(gameScene.gameVars.cyclone.parent, gameScene)
    }
}
