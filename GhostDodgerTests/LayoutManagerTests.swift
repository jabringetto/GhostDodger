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

    func setupScene(_ scene: SKScene) {
        setupSceneCalled = true
        guard let enterScene = scene as? EnterScene else { return }
        
        addBackground(enterScene)
        addLetters(enterScene)
    }

    func addBackground(_ scene: SKScene) {
        addedBackground = true
        guard let enterScene = scene as? EnterScene else { return }
        
        // Implement the actual background setup that's being tested
        enterScene.sceneVars.background.size.width = enterScene.sceneVars.screenWidth
        enterScene.sceneVars.background.size.height = enterScene.sceneVars.screenHeight
        enterScene.addChild(enterScene.sceneVars.background)
    }

    func addLetters(_ scene: EnterScene) {
        addedLetters = true
        // Implement the actual letter setup that's being tested
        for letter in scene.sceneVars.virusLetters {
            letter.zPosition = 4
            scene.sceneVars.letterLayer.addChild(letter)
        }
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

    func setupScene(_ scene: SKScene) {
        setupSceneCalled = true
        guard let gameScene = scene as? GameScene else { return }
        
        addBackground(gameScene)
        addBackLayer(gameScene)
        addBat(gameScene)
        addScoreLabel(gameScene)
        addHealthMeter(gameScene)
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
    }

    func testAddBackground() {
        // Act
        mockEnterManager.addBackground(enterScene)

        // Assert
        XCTAssertEqual(enterScene.sceneVars.background.size.width, 800)
        XCTAssertEqual(enterScene.sceneVars.background.size.height, 600)
        XCTAssertEqual(enterScene.sceneVars.background.parent, enterScene)
    }

    func testAddLetters() {
        // Arrange
        enterScene.sceneVars.virusLetters = [SKSpriteNode(imageNamed: "Letter_A"), SKSpriteNode(imageNamed: "Letter_B")]

        // Act
        mockEnterManager.addLetters(enterScene)

        // Assert
        XCTAssertEqual(enterScene.sceneVars.letterLayer.children.count, 2)
        XCTAssertEqual(enterScene.sceneVars.virusLetters[0].zPosition, 4)
        XCTAssertEqual(enterScene.sceneVars.virusLetters[1].zPosition, 4)
    }

    // MARK: - Game Scene Tests
    
    func testGameSceneLayoutManagerSetup() {
        // Act
        mockGameManager.setupScene(gameScene)

        // Assert
        XCTAssertTrue(mockGameManager.setupSceneCalled)
        XCTAssertTrue(mockGameManager.addedBackground)
        XCTAssertTrue(mockGameManager.addedBackLayer)
        XCTAssertTrue(mockGameManager.addedBat)
        XCTAssertTrue(mockGameManager.addedScoreLabel)
        XCTAssertTrue(mockGameManager.addedHealthMeter)
    }

    func testGameSceneAddBackground() {
        // Act
        mockGameManager.addBackground(gameScene)

        // Assert
        XCTAssertEqual(gameScene.gameVars.background.size.width, 800)
        XCTAssertEqual(gameScene.gameVars.background.size.height, 600)
        XCTAssertEqual(gameScene.gameVars.background.parent, gameScene)
    }

    func testGameSceneAddBackLayer() {
        // Act
        mockGameManager.addBackLayer(gameScene)

        // Assert
        XCTAssertEqual(gameScene.gameVars.backLayer.parent, gameScene)
    }

    func testGameSceneAddBat() {
        // Act
        mockGameManager.addBat(gameScene)

        // Assert
        XCTAssertEqual(gameScene.gameVars.bat.parent, gameScene.gameVars.backLayer)
    }
}
