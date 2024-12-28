import SpriteKit
import AVFoundation

protocol AssetLoadingService {
    func preloadAtlases(_ atlases: [String], progress: @escaping (Float) -> Void) async throws
    func preloadAudio(_ sounds: [(name: String, volume: Float)], progress: @escaping (Float) -> Void) async throws -> [String: AVAudioPlayer]
} 