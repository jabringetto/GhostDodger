import SpriteKit
import AVFoundation

class GameAssetLoader: AssetLoadingService {
    func preloadAtlases(_ atlases: [String], progress: @escaping (Float) -> Void) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            let group = DispatchGroup()
            var loadedCount = 0
            
            for atlasName in atlases {
                group.enter()
                SKTextureAtlas(named: atlasName).preload {
                    loadedCount += 1
                    progress(Float(loadedCount) / Float(atlases.count))
                    group.leave()
                }
            }
            
            group.notify(queue: .global()) {
                continuation.resume()
            }
        }
    }
    
    func preloadAudio(_ sounds: [(name: String, volume: Float)], progress: @escaping (Float) -> Void) async throws -> [String: AVAudioPlayer] {
        var players: [String: AVAudioPlayer] = [:]
        var loadedCount = 0
        
        for (soundName, volume) in sounds {
            if let url = Bundle.main.url(forResource: soundName.replacingOccurrences(of: ".mp3", with: ""), 
                                       withExtension: "mp3") {
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.volume = volume
                    player.prepareToPlay()
                    players[soundName] = player
                    
                    loadedCount += 1
                    progress(Float(loadedCount) / Float(sounds.count))
                } catch {
                    throw AssetLoadingError.audioLoadFailed(soundName: soundName)
                }
            } else {
                throw AssetLoadingError.audioFileMissing(soundName: soundName)
            }
        }
        
        return players
    }
}

enum AssetLoadingError: Error {
    case audioLoadFailed(soundName: String)
    case audioFileMissing(soundName: String)
} 