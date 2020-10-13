//
//  GameScene_Events.swift
//  KillVirus
//
//  Created by Jeremy Bringetto on 5/20/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit


extension GameScene: BatDelegate, GridDelegate, AnnouncerRoundCompletedDelegate, ForceFieldDelegate, CycloneDelegate
{

    func addBatDelegate()->Void {
        
        gameVars.bat.delegate = self
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
    func updateRoundLabel()->Void
    {
        gameVars.roundLabel.text = GameSceneConstants.roundLabelPrefix + String(gameVars.round)
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
        gameVars.scoreLabel.text = GameSceneConstants.scoreLabelPrefix + String(gameVars.score)
        
        if(gameVars.score > 100 &&  !gameVars.cycloneDeployed)
        {
            addCyclone()
        }
        savePersistentValues()
    }
 
    func removeAllPersistence()->Void
    {
        removePersisentValue(key:"score")
        removePersisentValue(key:"round")
        removePersisentValue(key: "forceFieldDeployed")
        clearRoundPersistence()
    }
    func clearRoundPersistence()->Void
    {
        removePersisentValue(key:"inProgress")
        removePersisentValue(key: "positionData")
        removePersisentValue(key: "backLayerPositionY")
        removePersisentValue(key: "batPositionX")
        removePersisentValue(key: "batPositionY")
        removePersisentValue(key:"health")
        removePersisentValue(key: "forceFieldDeployed")
        removePersisentValue(key: "forceFieldTimer")
        removePersisentValue(key: "cycloneDeployed")
        removePersisentValue(key: "cycloneTimer")
    }
    func resetGame()->Void
    {
        gameVars.backLayer.removeAllChildren()
        self.removeAllChildren()
        gameVars = varsInitialValues
        varsInitialValues = GameSceneVars()
        uptakePersistentValues()
        gameSetup()
        loadAllSounds()
    }
    func uptakePersistentValues()->Void
    {
       
        if let inProgress = fetchPersistentValue(key:"inProgress") as? Bool
        {
            gameVars.gameInProgress = inProgress
        }
        if let score = fetchPersistentValue(key:"score") as? UInt
        {
            gameVars.score = score
            gameVars.scoreLabel.text = GameSceneConstants.scoreLabelPrefix + String(gameVars.score)
        }
        if let round = fetchPersistentValue(key:"round") as? UInt
        {
            gameVars.round = round
        }
        if let layerPosY = fetchPersistentValue(key: "backLayerPositionY") as? CGFloat
        {
            gameVars.backLayer.position.y = layerPosY
        }

        if let healthPoints =  fetchPersistentValue(key: "health") as? UInt
        {
            gameVars.bat.healthPoints = healthPoints
        
        }
        if let isForceFieldDeployed =  fetchPersistentValue(key: "forceFieldDeployed") as? Bool
        {
            gameVars.forceFieldDeployed = isForceFieldDeployed
            if(gameVars.forceFieldDeployed)
            {
                if let forceFieldTimer = fetchPersistentValue(key: "forceFieldTimer") as? Int
                {
                           gameVars.forceField.timer = forceFieldTimer
                }
            }
        }
        if let isCycloneDeployed =  fetchPersistentValue(key: "cycloneDeployed") as? Bool
              {
                  gameVars.cycloneDeployed = isCycloneDeployed
                  if(gameVars.cycloneDeployed)
                  {
                      if let cycloneTimer = fetchPersistentValue(key: "cycloneTimer") as? Int
                      {
                            gameVars.cyclone.timer = cycloneTimer
                      }
                  }
              }
       
        
        
    }
    fileprivate func addForceField()->Void
    {
         gameVars.forceFieldDeployed = true
         guard gameVars.forceField.parent == nil  else {return}
         gameVars.forceField.delegate = self
         self.addChild(gameVars.forceField)
        
    }
    fileprivate func addCyclone()->Void
      {
           gameVars.cycloneDeployed = true
           guard gameVars.cyclone.parent == nil  else {return}
           gameVars.cyclone.delegate = self
           self.addChild(gameVars.cyclone)
          
      }
    private func removeForceField()->Void
    {
       
        guard gameVars.forceField.parent != nil  else {
            return
            
        }
        gameVars.forceField.removeFromParent()
        gameVars.forceFieldDeployed = false
       
    }
    private func removeCyclone()->Void
     {
        
         guard gameVars.cyclone.parent != nil  else {
             return
             
         }
         gameVars.cyclone.removeFromParent()
         gameVars.cycloneDeployed = false
        
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
    private func pointsLabelAdded(_ pointValue:UInt, _ position:CGPoint)
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
    
    // MARK: BatDelegate
    func batDied()
    {
        removeAllPersistence()
        removeForceField()
        removeCyclone()
        pauseButtonPressed()
        gameVars.pauseButton.isHidden = true
        recordDisplacement()
        showGameOver()
        
    }
    
    // MARK: ForceFieldDelegate
    func forceFieldCountdownComplete() {
        removeForceField()
    }
    
    // MARK: Cyclone Delegate
    func cycloneCountdownComplete() {
        removeCyclone()
    }
        

    
    // MARK: Grid Delegate, Persistence
    func savePersistentValues()->Void
     {
         savePersisentValue(value: gameVars.gameInProgress, key:"inProgress")
         savePersisentValue(value: gameVars.score, key: "score")
         savePersisentValue(value: gameVars.round, key: "round")
         savePersisentValue(value: gameVars.bat.healthPoints, key: "health")
         savePersisentValue(value: gameVars.backLayer.position.y, key: "backLayerPositionY")
         savePersisentValue(value: gameVars.bat.position.x, key: "batPositionX")
         savePersisentValue(value: gameVars.bat.position.y, key: "batPositionY")
         savePersisentValue(value: gameVars.forceFieldDeployed, key: "forceFieldDeployed")
         savePersisentValue(value: gameVars.forceField.timer, key: "forceFieldTimer")
         savePersisentValue(value: gameVars.cycloneDeployed, key: "cycloneDeployed")
         savePersisentValue(value: gameVars.cyclone.timer, key: "cycloneTimer")
        
    }
    func saveGridDataPeristently(positionData: [String : PositionAndType]) {
        
         defaults.set(try? PropertyListEncoder().encode(positionData), forKey: "positionData")
         defaults.synchronize()
    }
    func fetchPersistentGridData()->[PositionAndType]?
    {
        guard let positionDictData = defaults.object(forKey: "positionData") as? Data else { return nil }
        
        guard let positionData = try? PropertyListDecoder().decode([String:PositionAndType].self, from: positionDictData)  else { return nil }
        
        let positionsAndTypes:[PositionAndType] = Array(positionData.values)
        
        return positionsAndTypes
        
    }
    
    func savePersisentValue(value:Any, key:String)->Void
    {
         defaults.set(value, forKey: key)
         defaults.synchronize()
    }
    func removePersisentValue(key:String)->Void
    {
         defaults.removeObject(forKey:key)
         defaults.synchronize()
    }
    
    func fetchPersistentValue(key:String)->Any?
    {
        return defaults.object(forKey: key)
        
    }
     // MARK: AnnouncerRoundCompletedDelegate
    func currentRoundNumber() -> UInt
    {
        return gameVars.round
    }
    
}
