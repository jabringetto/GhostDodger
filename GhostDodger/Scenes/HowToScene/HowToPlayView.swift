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
                .frame(minHeight: 390)
                .padding(.top, 20)
                
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

