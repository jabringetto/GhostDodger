//
//  UpgradeScene.swift
//  KillVirus
//
//  Created by Jeremy Bringetto on 10/31/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit
import StoreKit

protocol UpgradesSceneDelegate: AnyObject {
    func updateVars(newVars: GameSceneVars)
    func showUpgradeAlert(upgradeType: UpgradeType, paid: Bool)
}

enum UpgradeType {
    case cyclone
    case forceField
}
struct UpgradeSceneConstants {
    static let upgradeSceneScaleMultiplier: CGFloat = 0.7
}
struct UpgradeSceneVars {
    var forceField = ForceField()
    var cyclone = Cyclone()
    var cycloneBlackBar = SKSpriteNode()
    var forceFieldBlackBar = SKSpriteNode()
    var cycloneUpgradeTitleLabel = SKLabelNode(fontNamed: "Arial-Bold")
    var forceFieldUpgradeTitleLabel =  SKLabelNode(fontNamed: "Arial-Bold")
    var cycloneUpgradeDescLabel = SKLabelNode(fontNamed: "Arial")
    var forceFieldUpgradeDescLabel =  SKLabelNode(fontNamed: "Arial")
    var cycloneReserveLabel = SKLabelNode(fontNamed: "Arial-Bold")
    var forceFieldReserveLabel =  SKLabelNode(fontNamed: "Arial-Bold")
    var pointsAvailableLabel =  SKLabelNode(fontNamed: "Arial-Bold")
    var cycloneDeployButton = MenuButton()
    var forceFieldDeployButton = MenuButton()
    var cycloneBuyButton = MenuButton()
    var forceFieldBuyButton = MenuButton()
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var batSpacing: CGFloat = 0.0
    var background = SKSpriteNode(imageNamed: "Background_NoBranches")
    var forceFieldBat = Bat()
    var cycloneBat = Bat()
    var batMoveSineArgument: CGFloat = 0.0
    var cycloneDeltaY: CGFloat = 0.0

    mutating func setScreenDimensions(_ width: CGFloat, _ height: CGFloat) {
        screenWidth = width
        screenHeight = height
        batSpacing = screenHeight/4.0
        cycloneDeltaY = GameSceneConstants.cyclonePositionDelta * UpgradeSceneConstants.upgradeSceneScaleMultiplier
    }

}

final class UpgradeScene: SKScene {
    weak var varsDelegate: UpgradesSceneDelegate?
    var upgradeVars = UpgradeSceneVars()
    var gameVars: GameSceneVars?

    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addBackground()
        addBats()
        addBlackBars()
        addUpgradeTitleLabels()
        addUpgradeDescriptionLabels()
        addUpgradeReserveLabels()
        addPointsAvailableLabel()
        addUpgradeBuyButtons()
        addUpgradeForceField()
        addUpgradeCyclone()

    }
    private func addBackground() {
        upgradeVars.background.size.width = upgradeVars.screenWidth
        upgradeVars.background.size.height = upgradeVars.screenHeight

        self.addChild(upgradeVars.background)
    }

    func addBats() {
        upgradeVars.cycloneBat.position.y =  upgradeVars.batSpacing
        upgradeVars.cycloneBat.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.cycloneBat.yScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.cycloneBat.flipAnimation()
        addChild(upgradeVars.cycloneBat)

        upgradeVars.forceFieldBat.position.y =  -upgradeVars.batSpacing
        upgradeVars.forceFieldBat.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.forceFieldBat.yScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        addChild(upgradeVars.forceFieldBat)
    }
    private func addBlackBars() {
        let barSize = CGSize(width: upgradeVars.screenWidth, height: 80.0)
        upgradeVars.cycloneBlackBar = SKSpriteNode(color: UIColor.black, size: barSize)
        upgradeVars.cycloneBlackBar.position = upgradeVars.cycloneBat.position
        upgradeVars.cycloneBlackBar.position.y = upgradeVars.cycloneBat.position.y + 90.0
        addChild(upgradeVars.cycloneBlackBar)

        upgradeVars.forceFieldBlackBar = SKSpriteNode(color: UIColor.black, size: barSize)
        upgradeVars.forceFieldBlackBar.position = upgradeVars.forceFieldBat.position
        upgradeVars.forceFieldBlackBar.position.y = upgradeVars.forceFieldBat.position.y + 120.0
        addChild(upgradeVars.forceFieldBlackBar)
    }
    private func addUpgradeTitleLabels() {
        let yPosTitle =  0.25 * upgradeVars.cycloneBlackBar.size.height
        upgradeVars.cycloneUpgradeTitleLabel.fontSize = 20.0
        upgradeVars.cycloneUpgradeTitleLabel.fontColor = .white
        upgradeVars.cycloneUpgradeTitleLabel.text = "C Y C L O N E "

        upgradeVars.cycloneUpgradeTitleLabel.position.y = yPosTitle
        upgradeVars.cycloneBlackBar.addChild(upgradeVars.cycloneUpgradeTitleLabel)

        upgradeVars.forceFieldUpgradeTitleLabel.fontSize = 20.0
        upgradeVars.forceFieldUpgradeTitleLabel.fontColor = .white
        upgradeVars.forceFieldUpgradeTitleLabel.text = "F O R C E  F I E L D"
        upgradeVars.forceFieldUpgradeTitleLabel.position.y = yPosTitle
        upgradeVars.forceFieldBlackBar.addChild(upgradeVars.forceFieldUpgradeTitleLabel)

    }
    private func addUpgradeDescriptionLabels() {
        let yPosDesc: CGFloat =  0.0
        upgradeVars.cycloneUpgradeDescLabel.fontSize = 14.0
        upgradeVars.cycloneUpgradeDescLabel.fontColor = .white
        upgradeVars.cycloneUpgradeDescLabel.text = "Suck down virus and treasure: 30 seconds | 800 pts/$0.99."
        upgradeVars.cycloneUpgradeDescLabel.position.y = yPosDesc
        upgradeVars.cycloneBlackBar.addChild(upgradeVars.cycloneUpgradeDescLabel)

        upgradeVars.forceFieldUpgradeDescLabel.fontSize = 14.0
        upgradeVars.forceFieldUpgradeDescLabel.fontColor = .white
        upgradeVars.forceFieldUpgradeDescLabel.text = "Repel all incoming virus: 30 seconds | 800 pts/$0.99."
        upgradeVars.forceFieldUpgradeDescLabel.position.y = yPosDesc
        upgradeVars.forceFieldBlackBar.addChild(upgradeVars.forceFieldUpgradeDescLabel)

    }
    private func addUpgradeReserveLabels() {
        let yPosMenu =  -0.35 * upgradeVars.cycloneBlackBar.size.height
        upgradeVars.cycloneReserveLabel.fontSize = 14.0
        upgradeVars.cycloneReserveLabel.fontColor = .white
        upgradeVars.cycloneReserveLabel.text = "RESERVE: " + String(gameVars?.cycloneReserve ?? 0)
        upgradeVars.cycloneReserveLabel.position.y = yPosMenu
        upgradeVars.cycloneReserveLabel.position.x = 0.5 * (upgradeVars.cycloneReserveLabel.frame.size.width - upgradeVars.screenWidth) + 10.0
        upgradeVars.cycloneBlackBar.addChild(upgradeVars.cycloneReserveLabel)

        upgradeVars.forceFieldReserveLabel.fontSize = 14.0
        upgradeVars.forceFieldReserveLabel.fontColor = .white
        upgradeVars.forceFieldReserveLabel.text = "RESERVE: " + String(gameVars?.forceFieldReserve ?? 0)
        upgradeVars.forceFieldReserveLabel.position.y = yPosMenu
        upgradeVars.forceFieldReserveLabel.position.x = 0.5 * (upgradeVars.forceFieldReserveLabel.frame.size.width - upgradeVars.screenWidth) + 10.0
        upgradeVars.forceFieldBlackBar.addChild(upgradeVars.forceFieldReserveLabel)

    }
    private func addPointsAvailableLabel() {
        let yPosMenu =  -0.35 * upgradeVars.cycloneBlackBar.size.height
        upgradeVars.pointsAvailableLabel.fontSize = 14.0
        upgradeVars.pointsAvailableLabel.fontColor = .white
        upgradeVars.pointsAvailableLabel.text = "POINTS: " + String(gameVars?.score ?? 0)
        upgradeVars.pointsAvailableLabel.position.y = yPosMenu
        upgradeVars.pointsAvailableLabel.position.x = 0.5 * (upgradeVars.screenWidth - upgradeVars.pointsAvailableLabel.frame.size.width) - 20.0
        upgradeVars.pointsAvailableLabel.position.x = 0.5 * (upgradeVars.screenWidth - upgradeVars.pointsAvailableLabel.frame.size.width) - 20.0
        upgradeVars.cycloneBlackBar.addChild(upgradeVars.pointsAvailableLabel)
    }
    private func addUpgradeBuyButtons() {
        let yPosMenu =  -0.35 * upgradeVars.cycloneBlackBar.size.height
        upgradeVars.cycloneBuyButton.setup(text: "BUY", nodeName: "buyButtonCyclone")
        upgradeVars.forceFieldBuyButton.setup(text: "BUY", nodeName: "buyButtonForceField")
        upgradeVars.cycloneBuyButton.position.y = yPosMenu
        upgradeVars.forceFieldBuyButton.position.y = yPosMenu
        upgradeVars.cycloneBlackBar.addChild(upgradeVars.cycloneBuyButton)
        upgradeVars.forceFieldBlackBar.addChild(upgradeVars.forceFieldBuyButton)
    }
    func moveBatsSinusoidally() {
        let delta: CGFloat = CGFloat.pi
        upgradeVars.batMoveSineArgument += CGFloat.pi / 180.0
        upgradeVars.forceFieldBat.position.x =  0.3 * upgradeVars.screenWidth * sin(upgradeVars.batMoveSineArgument + delta)
        upgradeVars.cycloneBat.position.x =  0.3 * upgradeVars.screenWidth * sin(upgradeVars.batMoveSineArgument)
        if upgradeVars.batMoveSineArgument >= 2.0 * CGFloat.pi {
            upgradeVars.batMoveSineArgument = 0
        }

    }
    fileprivate func addUpgradeForceField() {
        upgradeVars.forceField.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.forceField.yScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        self.addChild(upgradeVars.forceField)

    }
    fileprivate func addUpgradeCyclone() {         upgradeVars.cyclone.xScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        upgradeVars.cyclone.yScale *= UpgradeSceneConstants.upgradeSceneScaleMultiplier
        self.addChild(upgradeVars.cyclone)

    }

    func buyCycloneAlert() {
        guard let gameVars = gameVars else { return }
        let pointsAvailable = gameVars.score
        if pointsAvailable >= GameSceneConstants.cycloneUpgradePrice {
            varsDelegate?.showUpgradeAlert(upgradeType: .cyclone, paid: false)
        } else {
            // StoreKit
            varsDelegate?.showUpgradeAlert(upgradeType: .cyclone, paid: true)
        }

    }
    func buyForceFieldAlert() {
        guard let gameVars = gameVars else { return }
        let pointsAvailable = gameVars.score
        if pointsAvailable >= GameSceneConstants.forceFieldUpgradePrice {
            varsDelegate?.showUpgradeAlert(upgradeType: .forceField, paid: false)
        } else {
            // StoreKit
            varsDelegate?.showUpgradeAlert(upgradeType: .forceField, paid: true)
        }
    }
    func addBoughtCyclone() {

        guard var gameVars = gameVars else { return }
        gameVars.cycloneReserve += 1
        self.gameVars = gameVars
        self.varsDelegate?.updateVars(newVars: gameVars)
        upgradeVars.cycloneReserveLabel.text = "RESERVE: " + String(gameVars.cycloneReserve)
    }
    func addBoughtForceField() {
        guard var gameVars = gameVars else { return }
        gameVars.forceFieldReserve += 1
        self.gameVars = gameVars
        self.varsDelegate?.updateVars(newVars: gameVars)
        upgradeVars.forceFieldReserveLabel.text = "RESERVE: " + String(gameVars.forceFieldReserve)
    }
    func buyCyclone() {
        guard var gameVars = gameVars else { return }
        let pointsAvailable = gameVars.score

        if pointsAvailable >= GameSceneConstants.cycloneUpgradePrice {
            gameVars.cycloneReserve += 1
            gameVars.score -=  GameSceneConstants.cycloneUpgradePrice
            self.gameVars = gameVars
            self.varsDelegate?.updateVars(newVars: gameVars)
            upgradeVars.cycloneReserveLabel.text = "RESERVE: " + String(gameVars.cycloneReserve)
            upgradeVars.pointsAvailableLabel.text = "POINTS: " + String(gameVars.score)

        } else {
            // StoreKit

        }
    }
    func buyForceField() {
        guard var gameVars = gameVars else { return }
        let pointsAvailable = gameVars.score
        if pointsAvailable >= GameSceneConstants.forceFieldUpgradePrice {
            gameVars.forceFieldReserve += 1
            gameVars.score -=  GameSceneConstants.forceFieldUpgradePrice
            self.gameVars = gameVars
            self.varsDelegate?.updateVars(newVars: gameVars)
            upgradeVars.forceFieldReserveLabel.text = "RESERVE: " + String(gameVars.forceFieldReserve)
            upgradeVars.pointsAvailableLabel.text = "POINTS: " + String(gameVars.score)

        } else {
            // StoreKit
        }

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        for node in nodes {
            if node.name == "buyButtonCyclone" {
                buyCycloneAlert()
            }
            if node.name == "buyButtonForceField" {
                buyForceFieldAlert()
            }
        }

    }

    override func update(_ currentTime: TimeInterval) {

        moveBatsSinusoidally()
        upgradeVars.forceField.position = upgradeVars.forceFieldBat.position
        upgradeVars.cyclone.position.x =  upgradeVars.cycloneBat.position.x
        upgradeVars.cyclone.position.y =  upgradeVars.cycloneBat.position.y - upgradeVars.cycloneDeltaY

    }

}

final class MenuButton: SKSpriteNode {

    let menuLabel = SKLabelNode(fontNamed: "Arial-Bold")
    func setup(text: String, nodeName: String) {
        menuLabel.fontSize = 18.0
        menuLabel.fontColor = UIColor(hex: "#add8ffff")
        menuLabel.text = text
        addChild(menuLabel)
        name = nodeName
    }
}
