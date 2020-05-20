//
//  GameScene.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 12/22/18.
//  Copyright © 2018 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


struct GameSceneConstants
{
   
    static let batScale:CGFloat = 0.4
    static let batVerticalPositionMultiplier:CGFloat = 0.1
    static let batFollowFingerRatio:CGFloat = 0.04
    static let batFollowFingerThreshold:CGFloat = 1.0
    static let batPhysicsBodySizeRatio:CGFloat = 0.2
    static let blackBarHeight:CGFloat = 90.0
    static let batMaxHealthPoints:Int = 20
     
    static let virusPhysicsBodySizeRatio:CGFloat = 0.4
    static let batAnimationTimePerFrame:TimeInterval = 0.01
    static let virusAnimationTimePerFrame:TimeInterval = 0.2
    static let gemScale:CGFloat = 0.3
    static let gemConvergeSpeed:CGFloat = 1.3
    static let getRotationConstant:TimeInterval = 0.02
    static let skullScaleFactor:CGFloat = 0.2
    static let skullFollowRange:CGFloat = 200.0
    static let skullFollowMarginY:CGFloat = -30.0
    static let virusScaleFactor:CGFloat = 0.15
    static let gridColumnHeight:CGFloat = 60.0
    static let gridNumColumns:Int = 6
    static let gridNumRows:Int = 1300
    static let gameItemPhysicsRadius:CGFloat = 0.4
    static let healthMeterPadding:CGFloat = 60.0
}
struct GameSceneVars
{
    var background = SKSpriteNode(imageNamed:"Background_Cropped")
    var backLayer = SKNode()
    var bat = Bat()
    var grid = Grid()
    var blackBar = SKSpriteNode(color: UIColor.black, size: CGSize.zero)
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    var backgroundSpeed:CGFloat = 2.0
    var skullFollowSpeed:CGFloat = 2.4
    var screenTouched = false
    var currentlyCapturedItem:SKSpriteNode?
    var currentTouchLocation:CGPoint?
    var buzzerSoundEffect:AVAudioPlayer?
    var treasureSoundEffect:AVAudioPlayer?
    var columnHalfWidth:CGFloat = 0.0
    var columnHeight:CGFloat = 60.0
    var healthMeter = HealthMeter()
    
    
    mutating func setScreenDimensions(_ width:CGFloat, _ height:CGFloat)->Void
    {
        screenWidth = width
        screenHeight = height
    }
    
}

final class GameScene: SKScene
{
   
    var gameVars = GameSceneVars()
   
    override func didMove(to view: SKView)
    {
        self.anchorPoint = CGPoint(x:0.5,y:0.5)
        addLayersAndGrid()
        addBat()
        configurePhysicsWorld()
        loadSounds()
        
    }


}
