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

extension EnterScene
    
{
    func addBackground()->Void
    {
    
        sceneVars.background.size.width = sceneVars.screenWidth
        sceneVars.background.size.height = sceneVars.screenHeight
        self.addChild(sceneVars.background)
    }
    func addLetters()->Void
    {
         
          for letter in sceneVars.virusLetters
          {
              sceneVars.letterLayer.addChild(letter)
          }

    }
    func addEnterBat()->Void
    {
       sceneVars.enterBat.xScale = EnterSceneConstants.enterBatScale
       sceneVars.enterBat.yScale = EnterSceneConstants.enterBatScale
       sceneVars.conveyorLayer.addChild(sceneVars.enterBat)
    }
    func addVirusWithFace()->Void
    {
        sceneVars.virusWithFace = VirusWithFace.init(GameItemType.virus)
        sceneVars.virusWithFace.position.x = EnterSceneConstants.conveyorSpacing
        sceneVars.conveyorLayer.addChild(sceneVars.virusWithFace)
    }
    func addEnterRuby()->Void
    {
        sceneVars.enterRuby.xScale = EnterSceneConstants.enterRubyScale
        sceneVars.enterRuby.yScale = EnterSceneConstants.enterRubyScale
        sceneVars.enterRuby.position.x = EnterSceneConstants.conveyorSpacing * 2.0
        sceneVars.enterRuby.spinSlowly()
        sceneVars.conveyorLayer.addChild(sceneVars.enterRuby)
    }
    func addEnterCoins()->Void
    {
        sceneVars.enterGoldCoin.xScale = 0.6
        sceneVars.enterGoldCoin.yScale = 0.6
        sceneVars.enterGoldCoin.position.x = EnterSceneConstants.conveyorSpacing * 2.6
        sceneVars.conveyorLayer.addChild(sceneVars.enterGoldCoin)
        
        sceneVars.enterSilverCoin.xScale = 0.6
        sceneVars.enterSilverCoin.yScale = 0.6
        sceneVars.enterSilverCoin.position.x = EnterSceneConstants.conveyorSpacing * 3.0
        sceneVars.conveyorLayer.addChild(sceneVars.enterSilverCoin)
    }
    func addEnterSkull()->Void
    {
        sceneVars.enterSkull.xScale = 1.0
        sceneVars.enterSkull.yScale = 1.0
        sceneVars.enterSkull.position.x = EnterSceneConstants.conveyorSpacing * 4.0
        sceneVars.conveyorLayer.addChild(sceneVars.enterSkull)
    }
    
    func setLetterPositions(width:CGFloat, height:CGFloat)->Void
    {
            sceneVars.letterV.position.x  =  -width * 0.23
            sceneVars.letterI.position.x = -width * 0.06
            sceneVars.letterR.position.x = width * 0.04
            sceneVars.letterU.position.x = width * 0.18
            sceneVars.letterS.position.x =  width * 0.32
        
            sceneVars.letterD.position.x = width * 0.6
            sceneVars.letterO.position.x = width * 0.82
            sceneVars.letterD_lowercase.position.x = width * 1.0
            sceneVars.letterG.position.x = width * 1.12
            sceneVars.letterE.position.x = width * 1.28
            sceneVars.letterR_lowercase.position.x = width * 1.4
        
      
        
        sceneVars.virusLetters.append( sceneVars.letterV)
        sceneVars.virusLetters.append( sceneVars.letterI)
        sceneVars.virusLetters.append( sceneVars.letterR)
        sceneVars.virusLetters.append( sceneVars.letterU)
        sceneVars.virusLetters.append( sceneVars.letterS)
        
        sceneVars.virusLetters.append( sceneVars.letterD)
        sceneVars.virusLetters.append( sceneVars.letterO)
        sceneVars.virusLetters.append( sceneVars.letterD_lowercase)
        sceneVars.virusLetters.append( sceneVars.letterG)
        sceneVars.virusLetters.append( sceneVars.letterE)
        sceneVars.virusLetters.append( sceneVars.letterR_lowercase)
        for letter in sceneVars.virusLetters
        {
            centerLetterVertically(letterNode: letter)
            letter.xScale = 0.8
            letter.yScale = 0.8
        }
        sceneVars.letterG.position.y -= sceneVars.letterG.size.height * 0.5
              
    }
    private func centerLetterVertically(letterNode:SKSpriteNode)->Void
    {
        letterNode.position.y = sceneVars.screenHeight * 0.30 + (letterNode.size.height * 0.5)
    }
    
}
