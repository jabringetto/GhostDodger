//
//  SoundManager.swift
//  GhostDodger
//
//  Created by Jeremy Bringetto on 12/28/24.
//  Copyright © 2024 Jeremy Bringetto. All rights reserved.
//

import AVFoundation

final class SoundManager: AudioManager {
    static let shared = SoundManager()
    private var soundPlayers: [String: AVAudioPlayer] = [:]
    
    private init() {} // Ensures we only have one instance
    
    func loadSound(_ filename: String, volume: Float) -> AVAudioPlayer? {
        if let existingPlayer = soundPlayers[filename] {
            return existingPlayer
        }
        
        guard let path = Bundle.main.path(forResource: filename, ofType: nil) else {
            print("Could not find sound file: \(filename)")
            return nil
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.volume = volume
            player.prepareToPlay()
            soundPlayers[filename] = player
            return player
        } catch {
            print("Could not load sound: \(filename)")
            return nil
        }
    }
    
    func playSound(_ player: AVAudioPlayer?) {
        guard let soundPlayer = player else {
            print("Failed to play sound")
            return
        }
        
        if soundPlayer.isPlaying {
            soundPlayer.pause()
            soundPlayer.currentTime = 0.0
            soundPlayer.play()
        } else {
            soundPlayer.play()
        }
    }
    
    func playBackgroundMusic(_ player: AVAudioPlayer?, loops: Int = -1) {
        guard let musicPlayer = player else { return }
        musicPlayer.numberOfLoops = loops
        musicPlayer.play()
    }
    
    func stopBackgroundMusic(_ player: AVAudioPlayer?) {
        player?.stop()
    }
    
    func preloadSounds(_ soundMappings: [(name: String, volume: Float)]) -> [String: AVAudioPlayer] {
        var players: [String: AVAudioPlayer] = [:]
        
        for (soundName, volume) in soundMappings {
            if let player = loadSound(soundName, volume: volume) {
                players[soundName] = player
            }
        }
        
        return players
    }
}
