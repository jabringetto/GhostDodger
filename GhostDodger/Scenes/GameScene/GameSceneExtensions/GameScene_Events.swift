//
//  GameScene_Events.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 5/20/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene: BatDelegate, GridDelegate, AnnouncerRoundCompletedDelegate, ForceFieldDelegate, CycloneDelegate {

    func addBatDelegate() {
        gameVars.bat.delegate = self
    }
    private func recordDisplacement() {
        gameVars.gameOverBackLayerDisplacement = gameVars.backLayer.position.y
    }
    private func showGameOver() {
        gameVars.gameOver.position.y = 0.0
        gameVars.gameOver.isHidden = false
    }
    private func hideGameOver() {
        gameVars.gameOver.position.y = GameSceneConstants.gameOverInitialPosition
        gameVars.gameOver.isHidden = true
    }
    func updateRoundLabel() {
        gameVars.roundLabel.text = GameSceneConstants.roundLabelPrefix + String(gameVars.round)
    }
    func updateHealthMeter() {
        gameVars.healthMeter.updateGreenBar(gameVars.bat.healthPoints,
                                            GameSceneConstants.batMaxHealthPoints)
    }
    
    func captureAndConverge(_ itemSprite: SKSpriteNode) {
        itemSprite.physicsBody = nil
        gameVars.currentlyCapturedItem = itemSprite
        let itemKey: String =  String(Float(itemSprite.position.x)) + String(Float(itemSprite.position.y))
        gameVars.grid.addConvergingPlayerSpriteForKey(sprite: itemSprite, key: itemKey)
    }
    
    func playerTouchesEnemy(_ enemyType: GameItemType) {
        guard enemyType == .skull || enemyType == .ghost else { print("Not an enemy!"); return }
        playSound(gameVars.buzzerSoundEffect)
        updateHealthMeter()
        switch enemyType {
        case .skull:
            gameVars.bat.die()
        case .ghost:
            gameVars.bat.hitByGhost()
        default:
            print("Not an enemy!") ; break
        }
    }
    
    func playerGetsTreasure(_ treasure: SKSpriteNode) {
        if let gem = treasure as? Gem {
            pointsLabelAdded(gem.pointValue, gem.position)
            gem.pointValue = 0
            playSound(gameVars.treasureSoundEffect)

        } else if let coin = treasure as? Coin {
            pointsLabelAdded(coin.pointValue, coin.position)
            coin.pointValue = 0
            playSound(gameVars.coinSoundEffect)

        }
        gameVars.scoreLabel.text = GameSceneConstants.scoreLabelPrefix + String(gameVars.score)
        savePersistentValues()
    }

    func addRandomUpgrade() {
        let diceRoll = Int.random(in: 1...6)
        let noUpgrades = !gameVars.cycloneDeployed && !gameVars.forceFieldDeployed

        if noUpgrades {
            if diceRoll < 4 {
                addCyclone()
            } else {
                addForceField()
            }
        }
    }
    func removeAllPersistence() {
        removePersisentValue(key: "score")
        removePersisentValue(key: "round")
        removePersisentValue(key: "forceFieldDeployed")
        clearRoundPersistence()
    }
    func clearRoundPersistence() {
        removePersisentValue(key: "inProgress")
        removePersisentValue(key: "positionData")
        removePersisentValue(key: "backLayerPositionY")
        removePersisentValue(key: "batPositionX")
        removePersisentValue(key: "batPositionY")
        removePersisentValue(key: "health")
        removePersisentValue(key: "forceFieldDeployed")
        removePersisentValue(key: "forceFieldTimer")
        removePersisentValue(key: "cycloneDeployed")
        removePersisentValue(key: "cycloneTimer")
    }
      
    func resetGame() {
        gameVars.backLayer.removeAllChildren()
        self.removeAllChildren()
        
        // Stop all sound effects but don't stop background music yet
        gameVars.coinSoundEffect?.stop()
        gameVars.buzzerSoundEffect?.stop()
        gameVars.treasureSoundEffect?.stop()
        
        // Reset game vars and scene
        gameVars = varsInitialValues
        varsInitialValues = GameSceneVars()
        uptakePersistentValues()
        
        // Now handle background music restart
        soundManager.stopGameSceneBackgroundMusic()
        setupAudioEngine()
        
        // Ensure we start the music from the beginning
        if let player = gameVars.backgroundMusicPlayer {
            player.currentTime = 0
            soundManager.playBackgroundMusic(player)
        }
        
        layoutManager.setupScene(self)
    }

    func resetUpgradeMinimums() {
        gameVars.forceFieldReserve = max(GameSceneConstants.forceFieldMinReserve, gameVars.forceFieldReserve)
        gameVars.cycloneReserve = max(GameSceneConstants.cycloneMinReserve, gameVars.cycloneReserve)
        updateUpgradeLabels()
    }
    private func updateUpgradeLabels() {
        gameVars.forceFieldDashboard.update(forceFieldReserve: gameVars.forceFieldReserve)
        gameVars.cycloneDashboard.update(cycloneReserve: gameVars.cycloneReserve )

    }
    func uptakePersistentValues() {

        if let inProgress = fetchPersistentValue(key: "inProgress") as? Bool {
            gameVars.gameInProgress = inProgress
        }
        if let score = fetchPersistentValue(key: "score") as? UInt {
            gameVars.score = score
            gameVars.scoreLabel.text = GameSceneConstants.scoreLabelPrefix + String(gameVars.score)
        }
        if let round = fetchPersistentValue(key: "round") as? UInt {
            gameVars.round = round
        }
        if let layerPosY = fetchPersistentValue(key: "backLayerPositionY") as? CGFloat {
            gameVars.backLayer.position.y = layerPosY
        }

        if let healthPoints =  fetchPersistentValue(key: "health") as? UInt {
            gameVars.bat.healthPoints = healthPoints

        }
        if let isForceFieldDeployed =  fetchPersistentValue(key: "forceFieldDeployed") as? Bool {
            gameVars.forceFieldDeployed = isForceFieldDeployed
            if gameVars.forceFieldDeployed {
                if let forceFieldTimer = fetchPersistentValue(key: "forceFieldTimer") as? Int {
                    gameVars.forceField.timer = forceFieldTimer
                }
            }
        }
        if let isCycloneDeployed =  fetchPersistentValue(key: "cycloneDeployed") as? Bool {
            gameVars.cycloneDeployed = isCycloneDeployed
            if gameVars.cycloneDeployed {
                if let cycloneTimer = fetchPersistentValue(key: "cycloneTimer") as? Int {
                    gameVars.cyclone.timer = cycloneTimer
                }
            }
        }
        if let forceFieldReserve = fetchPersistentValue(key: "forceFieldReserve") as? UInt {
            gameVars.forceFieldReserve = forceFieldReserve
        }
        if let cycloneReserve = fetchPersistentValue(key: "cycloneReserve" ) as? UInt {
            gameVars.cycloneReserve = cycloneReserve
        }

    }
    func addForceField() {
        let shouldAddForceField =  gameVars.forceFieldDashboard.activated && gameVars.gamePausedState == 0  && gameVars.forceFieldReserve > 0 && !gameVars.forceFieldDeployed

        if shouldAddForceField {
            guard gameVars.forceField.parent == nil  else {return}
            gameVars.forceFieldReserve -= 1
            gameVars.forceFieldDashboard.update(forceFieldReserve: gameVars.forceFieldReserve)
            gameVars.forceFieldDeployed = true
            gameVars.forceField.delegate = self
            gameVars.forceField.position = gameVars.bat.position
            self.addChild(gameVars.forceField)
        }
    }
    func addCyclone() {
        let shouldAddCyclone = gameVars.cycloneDashboard.activated && gameVars.gamePausedState == 0  && gameVars.cycloneReserve > 0 && !gameVars.cycloneDeployed
        
        if shouldAddCyclone {
            guard gameVars.cyclone.parent == nil  else {return}
            gameVars.cycloneDeployed = true
            gameVars.cycloneReserve -= 1
            gameVars.cycloneDashboard.update(cycloneReserve: gameVars.cycloneReserve)
            gameVars.cyclone.delegate = self
            self.addChild(gameVars.cyclone)
        }
    }
    func removeForceField() {

        guard gameVars.forceField.parent != nil  else {
            return

        }
        gameVars.forceField.removeFromParent()
        gameVars.forceFieldDeployed = false

    }
    func removeCyclone() {
        
        guard gameVars.cyclone.parent != nil  else {
            return
            
        }
        gameVars.cyclone.removeFromParent()
        gameVars.cycloneDeployed = false
        
    }
    func pauseButtonPressed() {
        gameVars.gamePausedState += 1
        if gameVars.gamePausedState == 1 {
            gameVars.pauseButton.texture = SKTexture(imageNamed: "PlayButton")
        }
        if gameVars.gamePausedState == 2 {
            gameVars.gamePausedState = 0
            gameVars.pauseButton.texture = SKTexture(imageNamed: "PauseButton")
        }
    }
    func pauseGame() {
        gameVars.gamePausedState = 1
        gameVars.pauseButton.texture = SKTexture(imageNamed: "PlayButton")
    }

    func screenTouched(_ location: CGPoint) {
        if location.y > -(gameVars.screenHeight*0.5 - gameVars.blackBar.frame.size.height - 17.0) {
            gameVars.currentTouchLocation = location
        }
    }
    func updateScoreAndReserveValues(_ newVars: GameSceneVars) {
        gameVars = newVars
        savePersistentValues()
        gameVars.scoreLabel.text = GameSceneConstants.scoreLabelPrefix + String(gameVars.score)
        gameVars.cycloneDashboard.update(cycloneReserve: gameVars.cycloneReserve)
        gameVars.forceFieldDashboard.update(forceFieldReserve: gameVars.forceFieldReserve)
    }
    private func pointsLabelAdded(_ pointValue: UInt, _ position: CGPoint) {
        if pointValue > 0 {
            gameVars.score += pointValue
            let pointsLabel = SKLabelNode(fontNamed: "Arial-Bold")
            pointsLabel.fontSize = 24.0
            pointsLabel.fontColor = .white
            pointsLabel.text = "+ " + String(pointValue) + " points"
            pointsLabel.position = position
            gameVars.backLayer.addChild(pointsLabel)
            let itemKey: String =  String(Float(pointsLabel.position.x)) + String(Float(pointsLabel.position.y))
            gameVars.pointsLabels[itemKey] = pointsLabel
        }
    }

    // MARK: BatDelegate
    func batDied() {
        removeAllPersistence()
        removeForceField()
        removeCyclone()
        pauseButtonPressed()
        gameVars.pauseButton.isHidden = true
        gameVars.upgradeButton.isHidden = true
        gameVars.forceFieldDashboard.isHidden = true
        gameVars.cycloneDashboard.isHidden = true
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
    func savePersistentValues() {
        savePersisentValue(value: gameVars.gameInProgress, key: "inProgress")
        savePersisentValue(value: gameVars.score, key: "score")
        savePersisentValue(value: gameVars.round, key: "round")
        savePersisentValue(value: gameVars.bat.healthPoints, key: "health")
        savePersisentValue(value: gameVars.backLayer.position.y, key: "backLayerPositionY")
        savePersisentValue(value: gameVars.bat.position.x, key: "batPositionX")
        savePersisentValue(value: gameVars.bat.position.y, key: "batPositionY")
        savePersisentValue(value: gameVars.forceFieldDeployed, key: "forceFieldDeployed")
        savePersisentValue(value: gameVars.forceField.timer, key: "forceFieldTimer")
        savePersisentValue(value: gameVars.forceFieldReserve, key: "forceFieldReserve")
        savePersisentValue(value: gameVars.cycloneDeployed, key: "cycloneDeployed")
        savePersisentValue(value: gameVars.cyclone.timer, key: "cycloneTimer")
        savePersisentValue(value: gameVars.cycloneReserve, key: "cycloneReserve")
        
    }
    func saveGridDataPeristently(positionData: [String: PositionAndType]) {
        
        defaults.set(try? PropertyListEncoder().encode(positionData), forKey: "positionData")
        defaults.synchronize()
    }
    func fetchPersistentGridData() -> [PositionAndType]? {
        guard let positionDictData = defaults.object(forKey: "positionData") as? Data else { return nil }
        
        guard let positionData = try? PropertyListDecoder().decode([String: PositionAndType].self, from: positionDictData)  else { return nil }
        
        let positionsAndTypes: [PositionAndType] = Array(positionData.values)
        
        return positionsAndTypes
        
    }
    
    func savePersisentValue(value: Any, key: String) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    func removePersisentValue(key: String) {
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    
    func fetchPersistentValue(key: String)->Any? {
        return defaults.object(forKey: key)
        
    }
    func convergedRemovedSpriteEvent(sprite: SKSpriteNode) {
        
        if let coin = sprite as? Coin {
            playerGetsTreasure(coin)
            playSound(gameVars.coinSoundEffect)
        }
        if let gem = sprite as? Gem {
            playerGetsTreasure(gem)
            playSound(gameVars.treasureSoundEffect)
        }
    }
    // MARK: AnnouncerRoundCompletedDelegate
    func currentRoundNumber() -> UInt {
        return gameVars.round
    }

}
