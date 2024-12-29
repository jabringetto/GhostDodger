//
//  GameSprite.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 10/25/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit
import SwiftUI

protocol ConvergeAndShrinkDelegate: AnyObject {

    func shrinkCompleted(sprite: SKSpriteNode)
}

class GameSprite: SKSpriteNode {
    var convergingOnCyclone = false
    weak var delegate: ConvergeAndShrinkDelegate?
}

struct GameSpriteInfo: Identifiable {
    let id = UUID()
    let atlasName: String
    let description: String
}

class SpriteScene: SKScene {
    private var sprite: SKSpriteNode?
    
    convenience init(atlasName: String, size: CGSize) {
        self.init(size: size)
        self.backgroundColor = .clear
        setupSprite(atlasName: atlasName)
    }
    
    private func setupSprite(atlasName: String) {
        let atlas = SKTextureAtlas(named: atlasName)
        var textures: [SKTexture] = []
        
        for index in 1...atlas.textureNames.count {
            let name = index < 10 ?
            "\(atlasName)000\(index).png" :
            "\(atlasName)00\(index).png"
            let texture = atlas.textureNamed(name)
            textures.append(texture)
        }
        
        guard !textures.isEmpty else { return }
        
        sprite = SKSpriteNode(texture: textures[0])
        if let sprite = sprite {
            sprite.position = CGPoint(x: size.width/2, y: size.height/2)
            sprite.setScale(0.4)
            addChild(sprite)
            
            let animation = SKAction.animate(with: textures,
                                             timePerFrame: GameSceneConstants.batAnimationTimePerFrame,
                                             resize: false,
                                             restore: true)
            sprite.run(SKAction.repeatForever(animation))
        }
    }
}

struct AnimatedSpriteView: UIViewRepresentable {
    let atlasName: String
    
    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.backgroundColor = .clear
        
        let scene = SpriteScene(atlasName: atlasName, size: CGSize(width: 150, height: 150))
        scene.scaleMode = .aspectFit
        
        view.presentScene(scene)
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {}
}
