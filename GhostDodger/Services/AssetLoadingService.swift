import SpriteKit
import AVFoundation

enum AssetLoadingError: Error {
    case audioLoadFailed(soundName: String)
    case audioFileMissing(soundName: String)
} 