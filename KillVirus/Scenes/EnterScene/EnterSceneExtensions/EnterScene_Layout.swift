//
//  EnterScene_Layout.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 7/19/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation

extension EnterScene {
    func addBackground() {

        sceneVars.background.size.width = sceneVars.screenWidth
        sceneVars.background.size.height = sceneVars.screenHeight
        self.addChild(sceneVars.background)
    }
    func addLetters() {
          for letter in sceneVars.virusLetters {
              sceneVars.letterLayer.addChild(letter)
          }

    }
    func addEnterBat() {
       sceneVars.enterBat.xScale = EnterSceneConstants.enterBatScale
       sceneVars.enterBat.yScale = EnterSceneConstants.enterBatScale
       sceneVars.conveyorLayer.addChild(sceneVars.enterBat)
    }
    func addVirusWithFace() {
        sceneVars.virusWithFace = VirusWithFace.init(GameItemType.virus)
        sceneVars.virusWithFace.position.x = EnterSceneConstants.conveyorSpacing
        sceneVars.conveyorLayer.addChild(sceneVars.virusWithFace)
    }
    func addEnterRuby() {
        sceneVars.enterRuby.xScale = EnterSceneConstants.enterRubyScale
        sceneVars.enterRuby.yScale = EnterSceneConstants.enterRubyScale
        sceneVars.enterRuby.position.x = EnterSceneConstants.conveyorSpacing * 2.0
        sceneVars.enterRuby.spinSlowly()
        sceneVars.conveyorLayer.addChild(sceneVars.enterRuby)
    }
    func addEnterCoins() {
        sceneVars.enterGoldCoin.xScale = EnterSceneConstants.enterCoinScale
        sceneVars.enterGoldCoin.yScale = EnterSceneConstants.enterCoinScale
        sceneVars.enterGoldCoin.position.x = EnterSceneConstants.conveyorSpacing * 2.6
        sceneVars.conveyorLayer.addChild(sceneVars.enterGoldCoin)

        sceneVars.enterSilverCoin.xScale = EnterSceneConstants.enterCoinScale
        sceneVars.enterSilverCoin.yScale = EnterSceneConstants.enterCoinScale
        sceneVars.enterSilverCoin.position.x = EnterSceneConstants.conveyorSpacing * 3.0
        sceneVars.conveyorLayer.addChild(sceneVars.enterSilverCoin)
    }
    func addEnterSkull() {
        sceneVars.enterSkull.xScale = 1.0
        sceneVars.enterSkull.yScale = 1.0
        sceneVars.enterSkull.position.x = EnterSceneConstants.conveyorSpacing * 4.0
        sceneVars.conveyorLayer.addChild(sceneVars.enterSkull)
    }

    func setLetterPositions(width: CGFloat, height: CGFloat) {
            sceneVars.letterV.position.x  =  -width * 0.23
            sceneVars.letterI.position.x = -width * 0.06
            sceneVars.letterR.position.x = width * 0.04
            sceneVars.letterU.position.x = width * 0.18
            sceneVars.letterS.position.x =  width * 0.32

            sceneVars.letterD.position.x = width * 0.6
            sceneVars.letterO.position.x = width * 0.82
            sceneVars.lowercaseLetterD.position.x = width * 1.0
            sceneVars.letterG.position.x = width * 1.12
            sceneVars.letterE.position.x = width * 1.28
            sceneVars.lowercaseLetterR.position.x = width * 1.4

        sceneVars.virusLetters.append( sceneVars.letterV)
        sceneVars.virusLetters.append( sceneVars.letterI)
        sceneVars.virusLetters.append( sceneVars.letterR)
        sceneVars.virusLetters.append( sceneVars.letterU)
        sceneVars.virusLetters.append( sceneVars.letterS)

        sceneVars.virusLetters.append( sceneVars.letterD)
        sceneVars.virusLetters.append( sceneVars.letterO)
        sceneVars.virusLetters.append( sceneVars.lowercaseLetterD)
        sceneVars.virusLetters.append( sceneVars.letterG)
        sceneVars.virusLetters.append( sceneVars.letterE)
        sceneVars.virusLetters.append( sceneVars.lowercaseLetterR)
        for letter in sceneVars.virusLetters {
            centerLetterVertically(letterNode: letter)
            letter.xScale = EnterSceneConstants.enterLettersScale
            letter.yScale = EnterSceneConstants.enterLettersScale
        }
        sceneVars.letterG.position.y -= sceneVars.letterG.size.height * 0.5

    }
    private func centerLetterVertically(letterNode: SKSpriteNode) {
        letterNode.position.y = sceneVars.screenHeight * 0.30 + (letterNode.size.height * 0.5)
    }

}
