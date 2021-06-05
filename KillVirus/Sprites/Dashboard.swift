//
//  Labels.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 5/17/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//
import Foundation
import SpriteKit

final class HealthMeter: SKSpriteNode {
    let maximumWidth: CGFloat = 80.0
    let grayBar = SKSpriteNode(color: UIColor.gray, size: CGSize(width: 80.0, height: 15.0))
    let greenBar = SKSpriteNode(color: UIColor.green, size: CGSize(width: 80.0, height: 15.0))
    let healthLabel = SKLabelNode(fontNamed: "Arial-Bold")
    let padding: CGFloat = 10.0

    func setup() {
        self.removeAllChildren()
        self.addChild(grayBar)
        self.addChild(greenBar)
        healthLabel.fontSize = 14.0
        healthLabel.fontColor = UIColor.white
        healthLabel.text = "H E A L T H"
        healthLabel.position = CGPoint(x: -1.0, y: 12.0)
        self.addChild(healthLabel)
    }
    func updateGreenBar(_ healthPoints: UInt, _ maxPoints: UInt) {
        let fraction = CGFloat(healthPoints)/CGFloat(maxPoints)
        let newWidth = maximumWidth*fraction
        greenBar.size = CGSize(width: newWidth, height: greenBar.size.height)
        let delta = (newWidth - maximumWidth)*0.5
        greenBar.position = CGPoint(x: delta, y: greenBar.position.y)

    }

}
final class CycloneDashboardIndicator: SKSpriteNode {
    var activated = true
    let miniCylone = Cyclone()
    let cycloneReserveLabel = SKLabelNode(fontNamed: "Arial-Bold")
    func setup(cycloneReserve: UInt) {
        self.removeAllChildren()
        miniCylone.xScale *= GameSceneConstants.cycloneDashboardScaleFactor
        miniCylone.yScale *= GameSceneConstants.cycloneDashboardScaleFactor
        miniCylone.position = CGPoint(x: -12.0, y: 0.0)
        cycloneReserveLabel.fontSize = 18.0
        cycloneReserveLabel.fontColor = UIColor.white
        cycloneReserveLabel.position =  CGPoint(x: 12.0, y: -5.0)
        cycloneReserveLabel.text = ": " + String(cycloneReserve)
        addChild(miniCylone)
        addChild(cycloneReserveLabel)
    }
    func update(cycloneReserve: UInt) {
        cycloneReserveLabel.text = ": " + String(cycloneReserve)
    }

}
final class ForceFieldDashboardIndicator: SKSpriteNode {
    var activated = true
    let miniForceField = ForceField()
    let forceFieldReserveLabel = SKLabelNode(fontNamed: "Arial-Bold")
    func setup(forceFieldReserve: UInt) {
        self.removeAllChildren()
        miniForceField.xScale *= GameSceneConstants.forceFieldDashboardScaleFactor
        miniForceField.yScale *= GameSceneConstants.forceFieldDashboardScaleFactor
        miniForceField.position = CGPoint(x: -12.0, y: 0.0)
        forceFieldReserveLabel.fontSize = 18.0
        forceFieldReserveLabel.fontColor = UIColor.white
        forceFieldReserveLabel.position =  CGPoint(x: 12.0, y: -5.0)
        forceFieldReserveLabel.text = ": " + String(forceFieldReserve)
        addChild(miniForceField)
        addChild(forceFieldReserveLabel)
    }
    func update(forceFieldReserve: UInt) {
        forceFieldReserveLabel.text = ": " + String(forceFieldReserve)
    }
}
