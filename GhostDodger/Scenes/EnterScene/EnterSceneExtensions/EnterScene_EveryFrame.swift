//
//  EnterScene_EveryFrame.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 7/19/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

extension EnterScene {
     // MARK: Every Frame
     override func update(_ currentTime: TimeInterval) {
        moveLayers()
        incrementCounters()
        moveLetters()
        moveCoins()
        moveSkull()
     }
    private func incrementCounters() {
        sceneVars.enterLettersSineArgument += CGFloat.pi / 30.0
        sceneVars.skullRotationCounter += 1
        if sceneVars.skullRotationCounter == 160 {
            sceneVars.skullRotationCounter = 0
        }

    }
    private func moveLetters() {

        for (index, sprite) in sceneVars.enterLetters.enumerated() {
            let delta = 2.0 * CGFloat(index) *  (CGFloat.pi / 30.0)
            sprite.position.y += 2.0 * sin(sceneVars.enterLettersSineArgument + delta)
       
        }
        sceneVars.letterO.zRotation += 0.5
        sceneVars.letterOh.zRotation -= 0.5
        sceneVars.letterUpperCaseG.zRotation = 0.1*cos(sceneVars.enterLettersSineArgument)
        sceneVars.letterH.zRotation = -0.1*sin(sceneVars.enterLettersSineArgument)
        sceneVars.letterD.zRotation = -0.1*sin(sceneVars.enterLettersSineArgument)
        sceneVars.letterS.zRotation = 0.25*cos(sceneVars.enterLettersSineArgument)
        sceneVars.letterT.zRotation = 0.5*sin(sceneVars.enterLettersSineArgument)
        sceneVars.letterE.zRotation = 0.25*cos(sceneVars.enterLettersSineArgument)
        sceneVars.lowercaseLetterD.zRotation = 0.5*sin(sceneVars.enterLettersSineArgument)
        sceneVars.letterG.zRotation = 0.25*cos(sceneVars.enterLettersSineArgument)
        sceneVars.lowercaseLetterR.zRotation = 0.5*sin(sceneVars.enterLettersSineArgument)
    }
    private func moveCoins() {
        sceneVars.enterGoldCoin.position.y += 1.0 * sin(sceneVars.enterLettersSineArgument * 0.5)
        sceneVars.enterGoldCoin.position.x += 1.0 * cos(sceneVars.enterLettersSineArgument * 0.5)
        sceneVars.enterGoldCoin.zRotation += cos(sceneVars.enterLettersSineArgument * 0.5) / 200.0
        sceneVars.enterSilverCoin.position.y += 1.0 * cos(sceneVars.enterLettersSineArgument * 0.5)
        sceneVars.enterSilverCoin.position.x += 1.0 * sin(sceneVars.enterLettersSineArgument * 0.5)
        sceneVars.enterSilverCoin.zRotation += sin(sceneVars.enterLettersSineArgument * 0.5) / 200.0
    }
    private func moveSkull() {
        let skullRotation = sceneVars.enterLettersSineArgument / 3.0
        if sceneVars.skullRotationCounter < 10 {
            sceneVars.enterSkull.zRotation += skullRotation
        }
        if sceneVars.skullRotationCounter > 130 {
            sceneVars.enterSkull.zRotation -= skullRotation
        }
    }
     private func moveLayers() {
        sceneVars.conveyorLayer.position.x -= EnterSceneConstants.conveyorSpeed
        sceneVars.letterLayer.position.x -= 4.0 * EnterSceneConstants.conveyorSpeed
        if sceneVars.letterLayer.position.x < -2.0 * sceneVars.lowercaseLetterR.position.x {
            sceneVars.letterLayer.position.x  +=  sceneVars.lowercaseLetterR.position.x * 3.0
        }
        if sceneVars.conveyorLayer.position.x < -5.0 * EnterSceneConstants.conveyorSpacing {
            sceneVars.conveyorLayer.position.x += 6.0 * EnterSceneConstants.conveyorSpacing
        }

     }

}
