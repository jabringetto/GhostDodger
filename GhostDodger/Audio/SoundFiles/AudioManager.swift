//
//  Audio.swift
//  GhostDodger
//
//  Created by Jeremy Bringetto on 12/28/24.
//  Copyright © 2024 Jeremy Bringetto. All rights reserved.
//

import AVFoundation

protocol AudioManager {
    func loadSound(_ filename: String, volume: Float) -> AVAudioPlayer?
    func playSound(_ player: AVAudioPlayer?)
    func playBackgroundMusic(_ player: AVAudioPlayer?, loops: Int)
    func stopBackgroundMusic(_ player: AVAudioPlayer?)
    func preloadSounds(_ soundMappings: [(name: String, volume: Float)]) -> [String: AVAudioPlayer]
}

