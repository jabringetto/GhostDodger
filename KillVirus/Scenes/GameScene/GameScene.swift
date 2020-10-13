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
    static let nominalBackgroundSpeed:CGFloat = 2.0
    static let batAnimationTimePerFrame:TimeInterval = 0.01
    static let batFollowFingerRatio:CGFloat = 0.04
    static let batFollowFingerThreshold:CGFloat = 1.0
    static let batDeathBackgroundAcceration:CGFloat  = 0.2
    static let announcerScreenWidthRatio:CGFloat = 0.90
    static let batDeathConvergeSpeed:CGFloat = 0.75
    static let batDeathScaleSpeed:CGFloat = 0.03
    static let batDeathScaleThreshold:CGFloat = 0.8
    static let batDeathRotationSpeed:CGFloat = 0.06
    static let batDeathAlphaThreshold:CGFloat = 0.01
    static let batDeathConvergenceThreshold:CGFloat = 1.0
    static let batDeathAlphaSpeed:CGFloat = 0.12
    static let gameOverConvergenceYPos:CGFloat = 300.0
    static let gameOverConvergenceCoefficent:CGFloat = 0.99
    static let announcerAspectRatio:CGFloat = 0.574
    static let gameOverInitialPosition:CGFloat = 1000.0
    static let batScale:CGFloat = 0.4
    static let batVerticalPositionMultiplier:CGFloat = 0.25
    static let batPhysicsBodySizeRatio:CGFloat = 0.2
    static let buzzerSoundEffectVolume:Float = 0.03
    static let coinSoundEffectVolume:Float = 0.09
    static let batMaxHealthPoints:UInt = 20
    static let blackBarHeight:CGFloat = 90.0
    static let coinXScale:CGFloat = 0.3
    static let coinYScale:CGFloat = 0.2
    static let virusPhysicsBodySizeRatio:CGFloat = 0.4
    static let virusAnimationTimePerFrame:TimeInterval = 0.2
    static let gemScale:CGFloat = 0.3
    static let gemConvergeSpeed:CGFloat = 1.3
    static let gemRotationConstant:TimeInterval = 0.02
    static let skullScaleFactor:CGFloat = 0.2
    static let skullFollowRange:CGFloat = 200.0
    static let skullFollowMarginY:CGFloat = -30.0
    static let spriteSizeShrinkMultiplier:CGFloat = 0.96
    static let spriteSizeShrinkThreshold:CGFloat = 0.1
    static let virusScaleFactor:CGFloat = 0.15
    static let gridColumnHeight:CGFloat = 60.0
    static let gridNumColumns:Int = 6
    static let gridNumRows:Int = 500
    static let gameItemPhysicsRadius:CGFloat = 0.4
    static let healthMeterPadding:CGFloat = 60.0
    static let scoreLabelPadding:CGFloat = 50.0
    static let roundLabelPadding:CGFloat = 70.0
    static let pointValueSilverPiece:UInt = 5
    static let pointValueGoldPiece:UInt = 25
    static let basePointValueEmerald:UInt = 50
    static let basePointValueRuby:UInt = 100
    static let pointLabelFadeMultiplier:CGFloat = 0.99
    static let pointLabelVelocity:CGFloat = 0.8
    static let pointLabelAlphaThreshold:CGFloat = 0.3
    static let forceFieldScaleConstant:CGFloat = 0.6
    static let scoreLabelPrefix = "SCORE: "
    static let roundLabelPrefix = "ROUND: "
    
}
struct GameSceneVars
{
    var gameInProgress:Bool = false
    var forceFieldDeployed:Bool = false
    var cycloneDeployed:Bool = false
    var backLayer = SKNode()
    var bat = Bat()
    var grid = Grid()
    var forceField = ForceField()
    var cyclone = Cyclone()
    var healthMeter = HealthMeter()
    var countdownAnnouncer = AnnouncerCountdown()
    var roundCompleteAnnouncer = AnnouncerRoundCompleted()
    var score:UInt = 0
    var round:UInt = 1
    var persistenceCounter:UInt = 0
    var background = SKSpriteNode(imageNamed:"Background_Cropped")
    var pauseButton =  SKSpriteNode(imageNamed:"PauseButton")
    var gameOver = SKSpriteNode(imageNamed:"GameOver")
    var isCountingDown:Bool = true
    var countdownCounter:Int = 240
    var gamePausedState:Int = 1
    var gameOverbouncingBack:Bool = false
    var gameOverBackLayerDisplacement:CGFloat = 400.0
    var blackBar = SKSpriteNode(color: UIColor.black, size: CGSize.zero)
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    var batDeathBackgroundVelocity:CGFloat = 0.0
    var skullFollowSpeed:CGFloat = 2.4
    var screenTouched = false
    var currentlyCapturedItem:SKSpriteNode?
    var currentTouchLocation:CGPoint?
    var buzzerSoundEffect:AVAudioPlayer?
    var treasureSoundEffect:AVAudioPlayer?
    var coinSoundEffect:AVAudioPlayer?
    var columnHalfWidth:CGFloat = 0.0
    var columnHeight:CGFloat = 60.0
    var roundEndPosition:CGFloat = 10000.0
    var scoreLabel = SKLabelNode()
    var roundLabel = SKLabelNode()
    var pointsLabels = [String:SKLabelNode]()
    var virusOccurenceLowerLimit:UInt = 80
    var skullOccurenceLowerLimit:UInt = 85
   
    
    
    mutating func setScreenDimensions(_ width:CGFloat, _ height:CGFloat)->Void
    {
        screenWidth = width
        screenHeight = height
    }
    
}

final class GameScene: SKScene
{
   
    var gameVars = GameSceneVars()
    var varsInitialValues = GameSceneVars()
    let defaults = UserDefaults.standard
   
    override func didMove(to view: SKView)
    {
        self.anchorPoint = CGPoint(x:0.5,y:0.5)
        gameSetup()
        configurePhysicsWorld()
        loadAllSounds()
        
    }


}
