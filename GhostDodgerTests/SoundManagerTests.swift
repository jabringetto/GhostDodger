//
//  SoundManagerTests.swift
//  Ghost DodgerTests
//
//  Created by Jeremy Bringetto on 12/29/24.
//  Copyright © 2024 Jeremy Bringetto. All rights reserved.
//

import XCTest
import AVFoundation
@testable import Ghost_Dodger

final class Ghost_DodgerTests: XCTestCase {
    
    class MockEnterSoundManager: SoundManager {
        var loadSoundCalled = false
        var playSoundCalled = false
        var playBackgroundMusicCalled = false
        var stopBackgroundMusicCalled = false
        var preloadSoundsCalled = false
        var playEnterBackgroundMusicCalled = false
        var stopEnterBackgroundMusicCalled = false
        
        var lastLoadedFilename: String?
        var lastLoadedVolume: Float?
        var lastPlayedPlayer: AVAudioPlayer?
        var soundPlayers: [String: AVAudioPlayer] = [:]
        
        func loadSound(_ filename: String, volume: Float) -> AVAudioPlayer? {
            loadSoundCalled = true
            lastLoadedFilename = filename
            lastLoadedVolume = volume
            return nil
        }
        
        func playSound(_ player: AVAudioPlayer?) {
            playSoundCalled = true
            lastPlayedPlayer = player
        }
        
        func playBackgroundMusic(_ player: AVAudioPlayer?, loops: Int = -1) {
            playBackgroundMusicCalled = true
            lastPlayedPlayer = player
        }
        
        func stopBackgroundMusic(_ player: AVAudioPlayer?) {
            stopBackgroundMusicCalled = true
            lastPlayedPlayer = player
        }
        
        func preloadSounds(_ soundMappings: [(name: String, volume: Float)]) -> [String: AVAudioPlayer] {
            preloadSoundsCalled = true
            return soundPlayers
        }
        
        func playEnterBackgroundMusic() {
            playEnterBackgroundMusicCalled = true
        }
        
        func stopEnterBackgroundMusic() {
            stopEnterBackgroundMusicCalled = true
        }
    }
    
    class MockGameSoundManager: SoundManager {
        var loadSoundCalled = false
        var playSoundCalled = false
        var playBackgroundMusicCalled = false
        var stopBackgroundMusicCalled = false
        var preloadSoundsCalled = false
        var setupAudioEngineCalled = false
        var playGameSceneBackgroundMusicCalled = false
        var stopGameSceneBackgroundMusicCalled = false
        var assignSoundEffectsCalled = false
        
        var lastLoadedFilename: String?
        var lastLoadedVolume: Float?
        var soundPlayers: [String: AVAudioPlayer] = [:]
        
        func loadSound(_ filename: String, volume: Float) -> AVAudioPlayer? {
            loadSoundCalled = true
            lastLoadedFilename = filename
            lastLoadedVolume = volume
            return nil
        }
        
        func playSound(_ player: AVAudioPlayer?) {
            playSoundCalled = true
        }
        
        func playBackgroundMusic(_ player: AVAudioPlayer?, loops: Int = -1) {
            playBackgroundMusicCalled = true
        }
        
        func stopBackgroundMusic(_ player: AVAudioPlayer?) {
            stopBackgroundMusicCalled = true
        }
        
        func preloadSounds(_ soundMappings: [(name: String, volume: Float)]) -> [String: AVAudioPlayer] {
            preloadSoundsCalled = true
            return soundPlayers
        }
        
        func setupAudioEngine() -> [String: AVAudioPlayer] {
            setupAudioEngineCalled = true
            return soundPlayers
        }
        
        func playGameSceneBackgroundMusic() {
            playGameSceneBackgroundMusicCalled = true
        }
        
        func stopGameSceneBackgroundMusic() {
            stopGameSceneBackgroundMusicCalled = true
        }
        
        func assignSoundEffects(_ gameVars: inout GameSceneVars) {
            assignSoundEffectsCalled = true
        }
    }
    
    var mockEnterSoundManager: MockEnterSoundManager!
    var mockGameSoundManager: MockGameSoundManager!
    
    override func setUp() {
        super.setUp()
        mockEnterSoundManager = MockEnterSoundManager()
        mockGameSoundManager = MockGameSoundManager()
    }
    
    override func tearDown() {
        mockEnterSoundManager = nil
        mockGameSoundManager = nil
        super.tearDown()
    }
    
    // MARK: - EnterSoundManager Tests
    
    func testEnterSoundManagerLoadSound() {
        let filename = "test.mp3"
        let volume: Float = 0.5
        
        _ = mockEnterSoundManager.loadSound(filename, volume: volume)
        
        XCTAssertTrue(mockEnterSoundManager.loadSoundCalled)
        XCTAssertEqual(mockEnterSoundManager.lastLoadedFilename, filename)
        XCTAssertEqual(mockEnterSoundManager.lastLoadedVolume, volume)
    }
    
    func testEnterSoundManagerPlayBackgroundMusic() {
        mockEnterSoundManager.playBackgroundMusic(nil)
        XCTAssertTrue(mockEnterSoundManager.playBackgroundMusicCalled)
    }
    
    func testEnterSoundManagerStopBackgroundMusic() {
        mockEnterSoundManager.stopBackgroundMusic(nil)
        XCTAssertTrue(mockEnterSoundManager.stopBackgroundMusicCalled)
    }
    
    func testEnterSoundManagerPreloadSounds() {
        let soundMappings = [("test.mp3", Float(0.5))]
        _ = mockEnterSoundManager.preloadSounds(soundMappings)
        XCTAssertTrue(mockEnterSoundManager.preloadSoundsCalled)
    }
    
    func testEnterSoundManagerPlayEnterBackgroundMusic() {
        mockEnterSoundManager.playEnterBackgroundMusic()
        XCTAssertTrue(mockEnterSoundManager.playEnterBackgroundMusicCalled)
    }
    
    func testEnterSoundManagerStopEnterBackgroundMusic() {
        mockEnterSoundManager.stopEnterBackgroundMusic()
        XCTAssertTrue(mockEnterSoundManager.stopEnterBackgroundMusicCalled)
    }
    
    // MARK: - GameSoundManager Tests
    
    func testGameSoundManagerLoadSound() {
        let filename = "game.mp3"
        let volume: Float = 0.7
        
        _ = mockGameSoundManager.loadSound(filename, volume: volume)
        
        XCTAssertTrue(mockGameSoundManager.loadSoundCalled)
        XCTAssertEqual(mockGameSoundManager.lastLoadedFilename, filename)
        XCTAssertEqual(mockGameSoundManager.lastLoadedVolume, volume)
    }
    
    func testGameSoundManagerPlaySound() {
        mockGameSoundManager.playSound(nil)
        XCTAssertTrue(mockGameSoundManager.playSoundCalled)
    }
    
    func testGameSoundManagerPlayBackgroundMusic() {
        mockGameSoundManager.playBackgroundMusic(nil)
        XCTAssertTrue(mockGameSoundManager.playBackgroundMusicCalled)
    }
    
    func testGameSoundManagerStopBackgroundMusic() {
        mockGameSoundManager.stopBackgroundMusic(nil)
        XCTAssertTrue(mockGameSoundManager.stopBackgroundMusicCalled)
    }
    
    func testGameSoundManagerPreloadSounds() {
        let soundMappings = [("game.mp3", Float(0.7))]
        _ = mockGameSoundManager.preloadSounds(soundMappings)
        XCTAssertTrue(mockGameSoundManager.preloadSoundsCalled)
    }
    
    func testGameSoundManagerSetupAudioEngine() {
        _ = mockGameSoundManager.setupAudioEngine()
        XCTAssertTrue(mockGameSoundManager.setupAudioEngineCalled)
    }
    
    func testGameSoundManagerPlayGameSceneBackgroundMusic() {
        mockGameSoundManager.playGameSceneBackgroundMusic()
        XCTAssertTrue(mockGameSoundManager.playGameSceneBackgroundMusicCalled)
    }
    
    func testGameSoundManagerStopGameSceneBackgroundMusic() {
        mockGameSoundManager.stopGameSceneBackgroundMusic()
        XCTAssertTrue(mockGameSoundManager.stopGameSceneBackgroundMusicCalled)
    }
    
    func testGameSoundManagerAssignSoundEffects() {
        var gameVars = GameSceneVars()
        mockGameSoundManager.assignSoundEffects(&gameVars)
        XCTAssertTrue(mockGameSoundManager.assignSoundEffectsCalled)
    }
}
