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
     func addLayersAndGrid()
     {
        addBackground()
        addBackLayer()
        //addFrontLayer()
        setupGrid(gameVars.screenWidth,gameVars.screenHeight)
        
     }
     func addBat()->Void
     {
        GameSceneConstants.bat.position = CGPoint(x: 0.0, y: gameVars.screenHeight * GameSceneConstants.batVerticalPositionMultiplier)
            self.addChild(GameSceneConstants.bat)
     }
     private func addBackground()->Void
     {
        GameSceneConstants.background.size.width = gameVars.screenWidth
        GameSceneConstants.background.size.height = gameVars.screenHeight
        self.addChild(GameSceneConstants.background)
     }
     private func addBackLayer()->Void
     {
         self.addChild(GameSceneConstants.backLayer)
     }
//     private func addFrontLayer()->Void
//     {
//         self.addChild(GameSceneConstants.frontLayer)
//     }
     private func setupGrid(_ width:CGFloat, _ height: CGFloat)->Void
     {
         gameVars.grid = Grid.init(width,height)
         gameVars.grid.populateGridItems(GameSceneConstants.backLayer)
     }
    
}


