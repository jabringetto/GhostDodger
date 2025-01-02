//
//  EnterScene.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 5/3/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

struct EnterSceneConstants {
    static let conveyorSpeed: CGFloat = 0.25
    static let conveyorSpacing: CGFloat = 400.0
    static let enterBatScale: CGFloat = 1.2
    static let enterRubyScale: CGFloat = 2.0
    static let enterCoinScale: CGFloat = 0.6
    static let enterLettersScale: CGFloat = 0.8
}
struct EnterSceneVars {
     var screenWidth: CGFloat = 0.0
     var screenHeight: CGFloat = 0.0
     var background = SKSpriteNode(imageNamed: "Background_NoBranches")
     var conveyorLayer = SKNode()
     var letterLayer = SKNode()
     var virusWithFace = VirusWithFace()
     var enterBat = Bat()
     var enterRuby = Gem.init(.ruby)
     var enterGoldCoin = Coin.init(.goldCoin)
     var enterSilverCoin = Coin.init(.silverCoin)
     var enterSkull = Skull.init(.skull)
     var enterEmerald = Gem.init(.emerald)
     var enterGhost = Ghost.init(.ghost)
     var enterLetters = [SKSpriteNode]()
     var enterLettersSineArgument: CGFloat = 0.0
     var skullRotationCounter: Int = 0
    
     var letterUpperCaseG = SKSpriteNode(imageNamed: "Letter_G_Uppercase")
     var letterH = SKSpriteNode(imageNamed: "Letter_h")
     var letterOh = SKSpriteNode(imageNamed: "Letter_O")
     var letterS = SKSpriteNode(imageNamed: "Letter_S")
     var letterT = SKSpriteNode(imageNamed: "Letter_t")
    
     var letterD = SKSpriteNode(imageNamed: "Letter_D")
     var letterO = SKSpriteNode(imageNamed: "Letter_O")
     var lowercaseLetterD = SKSpriteNode(imageNamed: "Letter_D_lowercase")
     var letterG = SKSpriteNode(imageNamed: "Letter_G")
     var letterE = SKSpriteNode(imageNamed: "Letter_E")
     var lowercaseLetterR =  SKSpriteNode(imageNamed: "Letter_R_lowercase")
     var letterVPosition: CGPoint = CGPoint.zero
     var enterMusicPlayer: AVAudioPlayer?
     mutating func setScreenDimensions(_ width: CGFloat, _ height: CGFloat) {
        screenWidth = width
        screenHeight = height
     }
}

protocol EnterSceneDelegate: AnyObject {
    func didPressEnterButton()
}

final class EnterScene: SKScene {
    weak var enterSceneDelegate: EnterSceneDelegate?
    private let soundManager = EnterSoundManager.shared
    var sceneVars = EnterSceneVars()
    private let layoutManager = EnterSceneLayoutManager()
    private let enterButton = SKSpriteNode(imageNamed: "EnterButton")
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layoutManager.setupScene(self)
        setupEnterButton()
    }
    
    private func setupEnterButton() {
        // Scale down the button
        enterButton.xScale = 0.8
        enterButton.yScale = 0.8
        
        // Position the button lower on the screen (95% down)
        enterButton.position = CGPoint(x: 0, y: -(frame.height * 0.45))
        enterButton.name = "enterButton"
        enterButton.zPosition = 5
        
        // Create and configure smoke particle effect
        if let smokePath = Bundle.main.path(forResource: "SmokeParticles", ofType: "sks"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: smokePath)),
           let smokeParticles = try? NSKeyedUnarchiver.unarchivedObject(ofClass: SKEmitterNode.self, from: data) {
            smokeParticles.position = CGPoint(x: 0, y: -enterButton.size.height/2)
            smokeParticles.zPosition = 4
            smokeParticles.targetNode = self
            enterButton.addChild(smokeParticles)
        }
        
        addChild(enterButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        if touchedNodes.contains(enterButton) {
            enterButton.run(SKAction.sequence([
                SKAction.scale(to: 0.9, duration: 0.1),
                SKAction.scale(to: 1.0, duration: 0.1)
            ]))
            enterSceneDelegate?.didPressEnterButton()
        }
    }
}
