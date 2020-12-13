//
//  GameScene_Touches.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 1/24/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
     {
         gameVars.screenTouched = true
         let touch = touches.first!
         let location = touch.location(in:self)
         let nodes = self.nodes(at:location)
         for node in nodes
         {
            if (node.name == "pauseButton")
            {
                pauseButtonPressed()
            }
            if (node.name == "gameOver")
            {
                resetGame()
                resetUpgradeMinimums()
            }
            if (node.name == "roundCompletedPlayButton")
            {
                gameVars.round += 1
                savePersistentValues()
                clearRoundPersistence()
                removeForceField()
                removeCyclone()
                resetGame()
            }
            if(node.name == "upgradesButton")
            {
                self.gameSceneDelegate?.displayUpgradeScene()
            }
            if(node.name == "cycloneDashboardIndicator")
            {
                addCyclone()
            }
            if(node.name == "forceFieldDashboardIndicator")
            {
                addForceField()
            }
            
         }
        screenTouched(location)
       
     }
     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
     {
         
         let touch = touches.first!
         let location = touch.location(in:self)
         screenTouched(location)
         //gameVars.currentTouchLocation = location
         
     }
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first!
         let location = touch.location(in:self)
        // gameVars.currentTouchLocation = location
         screenTouched(location)
     }

    
}
