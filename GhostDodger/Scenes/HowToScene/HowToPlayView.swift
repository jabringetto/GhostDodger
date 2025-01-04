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
    @State private var rotation: Double = -5  // Initial rotation angle
    
    private let sprites: [GameSpriteInfo] = [
        GameSpriteInfo(atlasName: "Bat", description: "This is the player, this is you! During the game, place your finger on the screen and drag to fly around. The bat will always follow your finger as it moves."),
        GameSpriteInfo(atlasName: "Ghost", description: "Watch out! Don't let ghosts catch you or you'll lose health points as seen on your health meter. If you run out of health points, you die."),
        GameSpriteInfo(atlasName: "RubyFrame", description: "This is a ruby, an example of treasure you can collect to earn points. You may buy upgrades with the points you earn. Other types of treasure include emeralds, silver coins, and gold coins."),
        GameSpriteInfo(atlasName: "ForceField", description: "Buy this ForceField 3-pack upgrade for 800 points or $0.99 to repel all ghosts! Each force field lasts 30 seconds."),
        GameSpriteInfo(atlasName: "Skull", description: "Avoid skulls - they move through force fields and are instant death on contact!"),
        GameSpriteInfo(atlasName: "Whirlpool", description: "Buy this Cyclone 3-pack upgrade for 800 points or $0.99 to suck down ghosts and collect treasure. Each cyclone lasts 30 seconds."),
    ]
    
    var body: some View {
        ZStack {
            // Background image
            Image("Background_NoBranches")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Animated HowToPlay Image at the top
                Image("HowToPlay")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .padding(.top, 60)
                    .padding(.bottom, 0)
                    .rotationEffect(.degrees(rotation))
                    .onAppear {
                        // Create continuous rocking animation
                        withAnimation(
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: true)
                        ) {
                            rotation = 2  // Target rotation angle
                        }
                    }
                   
                // Sprite Carousel
                TabView(selection: $currentIndex) {
                    ForEach(sprites) { spriteInfo in
                        VStack {
                            Text(spriteInfo.description)
                                .font(.system(size: 23))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .frame(
                                    width: UIScreen.main.bounds.width - 40,
                                    alignment: .leading
                                )
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                            
                            AnimatedSpriteView(atlasName: spriteInfo.atlasName)
                                .frame(width: 195, height: 195)
                        }
                        .frame(maxHeight: .infinity)
                        .tag(sprites.firstIndex(where: { $0.id == spriteInfo.id }) ?? 0)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(minHeight: 200)
                .padding(.top, 00)
                
                Spacer()
                
                // Animated Play Now button
                Button(action: {
                    delegate?.didPressEnterButton()
                }) {
                    Image("PlayNowButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.5)
                        .rotationEffect(.degrees(rotation))
                }
                .padding(.bottom, 50)
                .onAppear {
                    // Create continuous rocking animation
                    withAnimation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: true)
                    ) {
                        rotation = 2  // Target rotation angle
                    }
                }
            }
        }
    }
}

