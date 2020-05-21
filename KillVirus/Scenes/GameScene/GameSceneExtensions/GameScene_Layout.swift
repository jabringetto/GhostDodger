//
//  GameScene_Layout.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 1/24/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit


extension GameScene
{
     func setupAndGrid()
     {
        addBackground()
        addBackLayer()
        addBlackBar()
        addHealthMeter()
        addScoreLabel()
        addPauseButton()
        setupGrid(gameVars.screenWidth,gameVars.screenHeight)
     }
     func addBat()->Void
     {
        gameVars.bat.position = CGPoint(x: 0.0, y: gameVars.screenHeight * GameSceneConstants.batVerticalPositionMultiplier)
            self.addChild(gameVars.bat)
     }
     private func addBackground()->Void
     {
        gameVars.background.size.width = gameVars.screenWidth
        gameVars.background.size.height = gameVars.screenHeight
        self.addChild(gameVars.background)
     }
     private func addBackLayer()->Void
     {
         self.addChild(gameVars.backLayer)
     }
     private func setupGrid(_ width:CGFloat, _ height: CGFloat)->Void
     {
         gameVars.grid = Grid.init(width,height)
         gameVars.grid.populateGridItems(gameVars.backLayer)
     }
     private func addBlackBar()->Void
     {
        gameVars.blackBar.size = CGSize(width: gameVars.screenWidth, height: GameSceneConstants.blackBarHeight)
        gameVars.blackBar.position = CGPoint(x: 0.0, y: -(gameVars.screenHeight / 2.0 - GameSceneConstants.blackBarHeight * 0.5))
        gameVars.blackBar.alpha = 0.7
        gameVars.blackBar.name = "blackBar"
        self.addChild(gameVars.blackBar)
     }
     private func addHealthMeter()->Void
     {
        gameVars.healthMeter.setup()
        gameVars.healthMeter.position = CGPoint(x: -gameVars.screenWidth / 2.0 + GameSceneConstants.healthMeterPadding, y:  -(gameVars.screenHeight / 2.0 - GameSceneConstants.healthMeterPadding))
        self.addChild(gameVars.healthMeter)
     }
     private func addScoreLabel()->Void
     {
        gameVars.scoreLabel = SKLabelNode(fontNamed: "Arial-Bold")
        gameVars.scoreLabel.fontSize = 18.0
        gameVars.scoreLabel.text = GameSceneConstants.scoreLabelPrefix + String(gameVars.score)
        gameVars.scoreLabel.position = CGPoint(x: 0.0 , y:  -(gameVars.screenHeight / 2.0 - GameSceneConstants.scoreLabelPadding))
        self.addChild( gameVars.scoreLabel)
     }
     private func addPauseButton()->Void
     {
        gameVars.pauseButton.position = CGPoint(x: gameVars.screenWidth / 2.0 - GameSceneConstants.healthMeterPadding*0.5, y: -(gameVars.screenHeight / 2.0 - GameSceneConstants.scoreLabelPadding))
        gameVars.pauseButton.name = "pauseButton"
         self.addChild(gameVars.pauseButton)
     }
    
}


