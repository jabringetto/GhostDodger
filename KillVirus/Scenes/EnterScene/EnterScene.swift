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
     var virusLetters = [SKSpriteNode]()
     var virusLettersSineArgument: CGFloat = 0.0
     var skullRotationCounter: Int = 0
     var letterV =  SKSpriteNode(imageNamed: "Letter_V")
     var letterI =  SKSpriteNode(imageNamed: "Letter_I")
     var letterR =  SKSpriteNode(imageNamed: "Letter_R")
     var letterU =  SKSpriteNode(imageNamed: "Letter_U")
     var letterS =  SKSpriteNode(imageNamed: "Letter_S")
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
class EnterScene: SKScene {

    var sceneVars = EnterSceneVars()

    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addBackground()
        self.addChild(sceneVars.conveyorLayer)
        self.addChild(sceneVars.letterLayer)
        addEnterGhost()
        addEnterBat()
        addEnterRuby()
        addEnterCoins()
        addEnterSkull()
        setLetterPositions(width: sceneVars.screenWidth, height: sceneVars.screenHeight)
        addLetters()
        loadEnterSceneBackgroundMusic()
        playEnterSceneBackgroundMusic()
    }
}
