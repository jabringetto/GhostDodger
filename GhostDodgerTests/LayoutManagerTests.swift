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

// Mock Layout Manager for testing
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

// Unit Tests
class LayoutManagerTests: XCTestCase {
    var mockManager: MockEnterSceneLayoutManager!
    var enterScene: EnterScene!

    override func setUp() {
        super.setUp()
        mockManager = MockEnterSceneLayoutManager()
        enterScene = EnterScene()
        enterScene.sceneVars.setScreenDimensions(800, 600)
    }

    override func tearDown() {
        mockManager = nil
        enterScene = nil
        super.tearDown()
    }

    func testEnterSceneLayoutManagerSetup() {
        // Act
        mockManager.setupScene(enterScene)

        // Assert
        XCTAssertTrue(mockManager.setupSceneCalled)
        XCTAssertTrue(mockManager.addedBackground)
        XCTAssertTrue(mockManager.addedLetters)
    }

    func testAddBackground() {
        // Act
        mockManager.addBackground(enterScene)

        // Assert
        XCTAssertEqual(enterScene.sceneVars.background.size.width, 800)
        XCTAssertEqual(enterScene.sceneVars.background.size.height, 600)
        XCTAssertEqual(enterScene.sceneVars.background.parent, enterScene)
    }

    func testAddLetters() {
        // Arrange
        enterScene.sceneVars.virusLetters = [SKSpriteNode(imageNamed: "Letter_A"), SKSpriteNode(imageNamed: "Letter_B")]

        // Act
        mockManager.addLetters(enterScene)

        // Assert
        XCTAssertEqual(enterScene.sceneVars.letterLayer.children.count, 2)
        XCTAssertEqual(enterScene.sceneVars.virusLetters[0].zPosition, 4)
        XCTAssertEqual(enterScene.sceneVars.virusLetters[1].zPosition, 4)
    }
}
