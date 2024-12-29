//
//  HowToPlayView.swift
//  GhostDodger
//
//  Created by Jeremy Bringetto on 12/28/24.
//  Copyright © 2024 Jeremy Bringetto. All rights reserved.
//

import SwiftUI
import SpriteKit
import AVFoundation

protocol HowToPlayViewDelegate: AnyObject {
    func didPressEnterButton()
}


struct HowToPlayView: View {
    weak var delegate: HowToPlayViewDelegate?
    var sceneVars = EnterSceneVars()
    @State private var currentIndex = 0
    
    private let sprites: [GameSpriteInfo] = [
        GameSpriteInfo(atlasName: "Bat", description: "This is the player, this is you! During the game, place your finger on the screen and drag to fly around. The bat will always follow your finger as it moves."),
        GameSpriteInfo(atlasName: "Ghost", description: "Watch out! Don't let ghosts catch you or you'll lose health points as seen on your health meter. If you run out of health points, you die."),
        GameSpriteInfo(atlasName: "RubyFrame", description: "This is a ruby, an example of treasure you can collect to earn points. You may buy upgrades with the points you earn. Other types of treasure include emeralds, silver coins, and gold coins."),
        GameSpriteInfo(atlasName: "ForceField", description: "Buy this ForceField upgrade for 800 points or $0.99 to repel all ghosts!"),
        GameSpriteInfo(atlasName: "Skull", description: "Avoid skulls - they move through force fields and are instant death on contact!"),
        GameSpriteInfo(atlasName: "Whirlpool", description: "Buy this Whirlpool upgrade for 800 points or $0.99 to suck down ghosts and collect treasure."),
    ]
    
    var body: some View {
        ZStack {
            // Background image
            Image("Background_NoBranches")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Title
                Text("How To Play")
                    .font(.system(size: 32, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                   
                
                // Sprite Carousel
                TabView(selection: $currentIndex) {
                    ForEach(sprites) { spriteInfo in
                        VStack {
                            Text(spriteInfo.description)
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .lineLimit(nil) // Allows unlimited lines
                                .frame(width: UIScreen.main.bounds.width - 40) // Fixed width with margins
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                            
                            AnimatedSpriteView(atlasName: spriteInfo.atlasName)
                                .frame(width: 150, height: 150)
                        }
                        .tag(sprites.firstIndex(where: { $0.id == spriteInfo.id }) ?? 0)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 300)
                
                Spacer()
                
                // Play Button
                Button(action: {
                    delegate?.didPressEnterButton()
                }) {
                    Text("P L A Y  N O W")
                        .font(.system(size: 32, weight: .regular))
                        .foregroundColor(.black)
                        .padding(.bottom, 50)
                }
                .padding(.bottom, 50)
            }
        }
    }
}

extension HowToPlayView{
    
    mutating func loadEnterSceneBackgroundMusic() {
        loadSound("VirusDodger_EnterScene.mp3", player: &sceneVars.enterMusicPlayer, volume: 0.5)
    }
    func playEnterSceneBackgroundMusic() {
        sceneVars.enterMusicPlayer?.numberOfLoops = -1
        sceneVars.enterMusicPlayer?.play()
    }
    func playSound(_ player: AVAudioPlayer?) {
        
        guard let soundPlayer = player else {
            print("failed to play sound")
            
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
    private func loadSound(_ filename: String, player:inout AVAudioPlayer?, volume: Float) {
        let path = Bundle.main.path(forResource: filename, ofType: nil) ?? ""
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = volume
            player?.prepareToPlay()        } catch {
                print("loading sound failed")
            }
        
    }
    
}

