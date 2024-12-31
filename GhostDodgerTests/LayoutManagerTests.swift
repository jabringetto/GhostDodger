//
//  LayoutManagerTests.swift
//  Ghost DodgerTests
//
//  Created by Jeremy Bringetto on 12/30/24.
//  Copyright © 2024 Jeremy Bringetto. All rights reserved.
//

import Testing
import SpriteKit
@testable import Ghost_Dodger

// Mock Layout Manager for testing
class MockEnterSceneLayoutManager: LayoutManager {
    var setupSceneCalled = false
    var addedBackground = false
    var addedLetters = false

   func setupScene(_ scene: SKScene) {
        setupSceneCalled = true
        setupScene(scene)
    }

    func addBackground(_ scene: SKScene) {
        addedBackground = true
        addBackground(scene)
    }

    func addLetters(_ scene: EnterScene) {
         addedLetters = true
         addLetters(scene)
    }
}

// Unit Tests
struct LayoutManagerTests {

    @Test func testEnterSceneLayoutManagerSetup() async throws {
        // Arrange
        let mockManager = MockEnterSceneLayoutManager()
        let enterScene = EnterScene()
        enterScene.sceneVars.setScreenDimensions(800, 600) // Set dimensions for testing

        // Act
        mockManager.setupScene(enterScene)

        // Assert
        #expect(mockManager.setupSceneCalled).to(equal(true))
        #expect(mockManager.addedBackground).to(equal(true))
        #expect(mockManager.addedLetters).to(equal(true))
    }

    @Test func testAddBackground() async throws {
        // Arrange
        let mockManager = MockEnterSceneLayoutManager()
        let enterScene = EnterScene()
        enterScene.sceneVars.setScreenDimensions(800, 600)

        // Act
        mockManager.addBackground(enterScene)

        // Assert
        #expect(enterScene.sceneVars.background.size.width).to(equal(800))
        #expect(enterScene.sceneVars.background.size.height).to(equal(600))
        #expect(enterScene.sceneVars.background.parent).to(equal(enterScene))
    }

    @Test func testAddLetters() async throws {
        // Arrange
        let mockManager = MockEnterSceneLayoutManager()
        let enterScene = EnterScene()
        enterScene.sceneVars.setScreenDimensions(800, 600)
        enterScene.sceneVars.virusLetters = [SKSpriteNode(imageNamed: "Letter_A"), SKSpriteNode(imageNamed: "Letter_B")]

        // Act
        mockManager.addLetters(enterScene)

        // Assert
        #expect(enterScene.sceneVars.letterLayer.children.count).to(equal(2))
        #expect(enterScene.sceneVars.virusLetters[0].zPosition).to(equal(4))
        #expect(enterScene.sceneVars.virusLetters[1].zPosition).to(equal(4))
    }
}
