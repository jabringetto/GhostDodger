import XCTest
import SpriteKit
import AVFoundation
@testable import Ghost_Dodger

class GameControllerTests: XCTestCase {
    var sut: GameController!
    var mockSceneFactory: MockSceneFactory!
    var mockAssetLoader: MockAssetLoader!
    var mockGameState: MockGameState!
    
    override func setUp() {
        super.setUp()
        mockSceneFactory = MockSceneFactory()
        mockAssetLoader = MockAssetLoader()
        mockGameState = MockGameState()
        sut = GameController(sceneFactory: mockSceneFactory,
                           assetLoader: mockAssetLoader,
                           gameState: mockGameState)
    }
    
    func testInitialSceneIsLoading() {
        sut.loadViewIfNeeded()
        XCTAssertTrue(mockSceneFactory.createLoadingSceneCalled)
    }
    
    func testAssetLoadingUpdatesProgress() async throws {
        sut.loadViewIfNeeded()
        let loadingScene = mockSceneFactory.lastCreatedLoadingScene
        
        try await sut.loadGameAssets(loadingScene: loadingScene)
        
        XCTAssertEqual(loadingScene.progress, 1.0)
        XCTAssertTrue(mockAssetLoader.preloadAtlasesCalled)
        XCTAssertTrue(mockAssetLoader.preloadAudioCalled)
    }
    
    func testAudioLoading() async throws {
        var progressValues: [Float] = []
        
        let sounds: [(name: String, volume: Float)] = [
            ("Coin01.mp3", 0.5),
            ("Buzzer.mp3", 0.7)
        ]
        
        let players = try await mockAssetLoader.preloadAudio(sounds) { progress in
            progressValues.append(progress)
        }
        
        XCTAssertEqual(players.count, 0) // Mock returns empty dictionary
        XCTAssertEqual(progressValues.count, 1) // Mock calls progress once with 1.0
        XCTAssertEqual(progressValues.last, 1.0)
        XCTAssertTrue(mockAssetLoader.preloadAudioCalled)
    }
}

// Mock implementations
class MockSceneFactory: SceneFactory {
    var createLoadingSceneCalled = false
    var lastCreatedLoadingScene: LoadingScene!
    
    func createLoadingScene(size: CGSize) -> LoadingScene {
        createLoadingSceneCalled = true
        lastCreatedLoadingScene = LoadingScene(size: size)
        return lastCreatedLoadingScene
    }
    
    func createGameScene(size: CGSize) -> GameScene {
        return GameScene(size: size)
    }
    
    func createEnterScene(size: CGSize) -> EnterScene {
        return EnterScene(size: size)
    }
}

class MockAssetLoader: AssetLoadingService {
    var preloadAtlasesCalled = false
    var preloadAudioCalled = false
    
    func preloadAtlases(_ atlases: [String], progress: @escaping (Float) -> Void) async throws {
        preloadAtlasesCalled = true
        progress(1.0)
    }
    
    func preloadAudio(_ sounds: [(name: String, volume: Float)], progress: @escaping (Float) -> Void) async throws -> [String: AVAudioPlayer] {
        preloadAudioCalled = true
        progress(1.0)
        return [:]
    }
}

class MockGameState: GameState {
    var score: UInt = 0
    var round: UInt = 1
    var isGameOver: Bool = false
    var isPaused: Bool = false
    
    func save() {
        // Mock implementation
    }
    
    func load() {
        // Mock implementation
    }
    
    func reset() {
        score = 0
        round = 1
        isGameOver = false
        isPaused = false
    }
} 