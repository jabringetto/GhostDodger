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
final class EnterScene: SKScene {
    private let soundManager = EnterSoundManager.shared
    var sceneVars = EnterSceneVars()
    private let layoutManager = EnterSceneLayoutManager()

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layoutManager.setupScene(self)
        
        #if DEBUG
        // Debug: Print node hierarchy
        printNodeHierarchy(self, level: 0)
        #endif
    }
    
    #if DEBUG
    private func printNodeHierarchy(_ node: SKNode, level: Int) {
        let indent = String(repeating: "  ", count: level)
        print("\(indent)Node: \(type(of: node)), zPosition: \(node.zPosition), position: \(node.position)")
        node.children.forEach { child in
            printNodeHierarchy(child, level: level + 1)
        }
    }
    #endif
}
