import SpriteKit
import AVFoundation

protocol AssetLoadingService {
    func preloadAtlases(_ atlases: [String], progress: @escaping (Float) -> Void) async throws
    func preloadAudio(_ sounds: [(name: String, volume: Float)], progress: @escaping (Float) -> Void) async throws -> [String: AVAudioPlayer]
}

protocol SceneFactory {
    func createLoadingScene(size: CGSize) -> LoadingScene
    func createGameScene(size: CGSize) -> GameScene
    func createEnterScene(size: CGSize) -> EnterScene
}

protocol GameState {
    var score: UInt { get set }
    var round: UInt { get set }
    var isGameOver: Bool { get set }
    var isPaused: Bool { get set }
    
    func save()
    func load()
    func reset()
} 