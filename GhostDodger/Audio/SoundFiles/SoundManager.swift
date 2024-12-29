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

extension SoundManager {
    // MARK: - EnterController Background Music
    func playEnterBackgroundMusic() {
        let filename = "VirusDodger_EnterScene.mp3"
        let volume: Float = 0.5
        guard let player = loadSound(filename, volume: volume) else { return }
        playBackgroundMusic(player)
    }
    
    func stopEnterBackgroundMusic() {
        let filename = "VirusDodger_EnterScene.mp3"
        guard let player = soundPlayers[filename] else { return }
        stopBackgroundMusic(player)
    }
    
    // MARK: - GameScene Background Music
    func playGameSceneBackgroundMusic() {
        let filename = "VirusDodger_GameScene.mp3"
        let volume: Float = 0.4
        guard let player = loadSound(filename, volume: volume) else { return }
        playBackgroundMusic(player)
    }
    
    func stopGameSceneBackgroundMusic() {
        let filename = "VirusDodger_GameScene.mp3"
        guard let player = soundPlayers[filename] else { return }
        stopBackgroundMusic(player)
    }
    
    // MARK: - HowToHostingController Background Music
    func playHowToHostingBackgroundMusic() {
        let filename = "VirusDodger_EnterScene.mp3"
        let volume: Float = 0.5
        guard let player = loadSound(filename, volume: volume) else { return }
        playBackgroundMusic(player)
    }
    
    func stopHowToHostingBackgroundMusic() {
        let filename = "VirusDodger_EnterScene.mp3"
        guard let player = soundPlayers[filename] else { return }
        stopBackgroundMusic(player)
    }
    
    // MARK: - Setup Audio Engine
    func setupAudioEngine() -> [String: AVAudioPlayer] {
        let soundMappings: [(name: String, volume: Float)] = [
            ("Coin01.mp3", GameSceneConstants.coinSoundEffectVolume),
            ("Buzzer.mp3", GameSceneConstants.buzzerSoundEffectVolume),
            ("Treasure.mp3", 1.0),
            ("VirusDodger_GameScene.mp3", 0.4)
        ]
        
        return preloadSounds(soundMappings)
    }
    
    func assignSoundEffects(_ gameVars: inout GameSceneVars) {
        
        let players = setupAudioEngine()
        
        // Set the appropriate game variable reference
        gameVars.coinSoundEffect = players["Coin01.mp3"]
        gameVars.buzzerSoundEffect = players["Buzzer.mp3"]
        gameVars.treasureSoundEffect = players["Treasure.mp3"]
        gameVars.backgroundMusicPlayer = players["VirusDodger_GameScene.mp3"]
        
        
    }
}
