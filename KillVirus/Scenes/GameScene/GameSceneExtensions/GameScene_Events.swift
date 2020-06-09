//
//  GameScene_Events.swift
//  KillVirus
//
//  Created by Jeremy Bringetto on 5/20/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit


extension GameScene:BatDelegate
{
    func addBatDelegate()->Void {
        
        gameVars.bat.delegate = self
    }
    func batDied()
    {
        pauseButtonPressed()
        gameVars.pauseButton.isHidden = true
        recordDisplacement()
        showGameOver()
        
    }
    private func recordDisplacement()->Void
    {
        gameVars.gameOverBackLayerDisplacement = gameVars.backLayer.position.y
    }
    private func showGameOver()->Void
    {
        gameVars.gameOver.position.y = 0.0
        gameVars.gameOver.isHidden = false
    }
    private func hideGameOver()->Void
    {
        gameVars.gameOver.position.y = GameSceneConstants.gameOverInitialPosition
        gameVars.gameOver.isHidden = true
    }
    
    func playerGetsTreasure(_ treasure:SKSpriteNode)->Void
    {
        if let gem = treasure as? Gem
        {
            pointsLabelAdded(gem.pointValue, gem.position)
           
        }
        else if let coin = treasure as? Coin
        {
            pointsLabelAdded(coin.pointValue, coin.position)
                 
        }
    }
    func resetGame()->Void
    {
        gameVars.backLayer.removeAllChildren()
        self.removeAllChildren()
        gameVars = varsInitialValues
        varsInitialValues = GameSceneVars()
        gameSetup()
        loadSounds()
    }
    func pauseButtonPressed()->Void
    {
        gameVars.gamePausedState += 1
        if(gameVars.gamePausedState == 1)
        {
            gameVars.pauseButton.texture = SKTexture(imageNamed: "PlayButton")
        }
        if(gameVars.gamePausedState == 2)
        {
            gameVars.gamePausedState = 0
            gameVars.pauseButton.texture = SKTexture(imageNamed: "PauseButton")
        }
    }
    func screenTouched(_ location:CGPoint)->Void
    {
        if(location.y > -(gameVars.screenHeight*0.5 - gameVars.blackBar.frame.size.height - 17.0))
        {
                gameVars.currentTouchLocation = location
        }
    }
    private func pointsLabelAdded(_ pointValue:Int, _ position:CGPoint)
    {
        gameVars.score += pointValue
        let pointsLabel = SKLabelNode(fontNamed: "Arial-Bold")
        pointsLabel.fontSize = 24.0
        pointsLabel.fontColor = .white
        pointsLabel.text = "+ " + String(pointValue) + " points"
        pointsLabel.position = position
        gameVars.backLayer.addChild(pointsLabel)
        let itemKey:String =  String(Float(pointsLabel.position.x)) + String(Float(pointsLabel.position.y))
        gameVars.pointsLabels[itemKey] = pointsLabel
    }
    
    
}
