import XCTest
import SpriteKit
import AVFoundation
@testable import Ghost_Dodger

class AssetLoadingTests: XCTestCase {
    var sut: GameAssetLoader!
    
    override func setUp() {
        super.setUp()
        sut = GameAssetLoader()
    }
    
    func testAtlasLoading() async throws {
        var progressValues: [Float] = []
        
        try await sut.preloadAtlases(["Bat", "Ghost"]) { progress in
            progressValues.append(progress)
        }
        
        XCTAssertEqual(progressValues.count, 2)
        XCTAssertEqual(progressValues.last, 1.0)
    }
    
    func testAudioLoading() async throws {
        var progressValues: [Float] = []
        
        let sounds = [
            ("Coin01.mp3", 0.5),
            ("Buzzer.mp3", 0.7)
        ]
        
        let players = try await sut.preloadAudio(sounds) { progress in
            progressValues.append(progress)
        }
        
        XCTAssertEqual(players.count, 2)
        XCTAssertEqual(progressValues.count, 2)
        XCTAssertEqual(progressValues.last, 1.0)
        XCTAssertNotNil(players["Coin01.mp3"])
        XCTAssertNotNil(players["Buzzer.mp3"])
    }
    
    func testAudioLoadingFailure() async {
        let sounds = [("NonExistentSound.mp3", 1.0)]
        
        do {
            _ = try await sut.preloadAudio(sounds) { _ in }
            XCTFail("Should have thrown an error")
        } catch AssetLoadingError.audioFileMissing(let soundName) {
            XCTAssertEqual(soundName, "NonExistentSound.mp3")
        } catch {
            XCTFail("Wrong error type thrown")
        }
    }
} 
