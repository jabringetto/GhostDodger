//
//  GameScene.swift
//  
//
//  Created by Jeremy Bringetto on 12/22/18.
//  Copyright © 2018 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

protocol  GameSceneDelegate: AnyObject {
    func displayUpgradeScene()
}
struct GameSceneConstants {
    static let nominalBackgroundSpeed: CGFloat = 2.0
    static let announcerAspectRatio: CGFloat = 0.574
    static let announcerScreenWidthRatio: CGFloat = 0.90
    static let batAnimationTimePerFrame: TimeInterval = 0.01
    static let batFollowFingerRatio: CGFloat = 0.04
    static let batFollowFingerThreshold: CGFloat = 1.0
    static let batScale: CGFloat = 0.4
    static let batVerticalPositionMultiplier: CGFloat = 0.25
    static let batPhysicsBodySizeRatio: CGFloat = 0.2
    static let batDeathBackgroundAcceration: CGFloat  = 0.2
    static let batDeathConvergeSpeed: CGFloat = 0.75
    static let batDeathScaleSpeed: CGFloat = 0.03
    static let batDeathScaleThreshold: CGFloat = 0.8
    static let batDeathRotationSpeed: CGFloat = 0.06
    static let batDeathAlphaThreshold: CGFloat = 0.01
    static let batDeathConvergenceThreshold: CGFloat = 1.0
    static let batDeathAlphaSpeed: CGFloat = 0.12
    static let blackBarAlpha: CGFloat = 0.7
    static let cyclonePositionDelta: CGFloat = 150.0
    static let cycloneInnerRadiusMultiplier: CGFloat = 0.3
    static let cycloneOuterRadiusMultiplier: CGFloat = 1.2
    static let cycloneDashboardScaleFactor: CGFloat = 0.15
    static let cycloneMinReserve: UInt = 1
    static let forceFieldDashboardScaleFactor: CGFloat = 0.12
    static let forceFieldMinReserve: UInt = 1
    static let totalCountdownDuration: Int = 240
    static let finalCountdownDuration: Int = 100
    static let gameOverConvergenceYPos: CGFloat = 300.0
    static let gameOverConvergenceCoefficent: CGFloat = 0.99
    static let gameOverInitialPosition: CGFloat = 1000.0
    static let gemScale: CGFloat = 0.3
    static let ghostScale: CGFloat = 0.2
    static let gameSceneHorizontalPadding: CGFloat = -20.0
    static let gameSceneBottomPadding: CGFloat = 25.0
    static let gemConvergeSpeed: CGFloat = 1.3
    static let gemRotationConstant: TimeInterval = 0.02
    static let buzzerSoundEffectVolume: Float = 0.1
    static let coinSoundEffectVolume: Float = 0.2
    static let batMaxHealthPoints: UInt = 20
    static let blackBarHeight: CGFloat = 90.0
    static let coinXScale: CGFloat = 0.3
    static let coinYScale: CGFloat = 0.2
    static let skullScaleFactor: CGFloat = 0.2
    static let skullFollowRange: CGFloat = 200.0
    static let skullFollowMarginY: CGFloat = -30.0
    static let ghostAnimationTimePerFrame: TimeInterval = 0.06
    static let skullAnimationTimePerFrame: TimeInterval = 0.02
    static let virusPhysicsBodySizeRatio: CGFloat = 0.4
    static let virusAnimationTimePerFrame: TimeInterval = 0.2
    static let virusWithFaceAnimationTimePerFrame: TimeInterval = 0.1
    static let virusNominalFollowSpeedMultiplier: CGFloat = 0.5
    static let virusForceFieldSpeedMultiplier: CGFloat = -3.0
    static let virusCycloneSpeedMultiplier: CGFloat = 2.4
    static let virusConvergenceSpeedMultiplier: CGFloat = 0.25
    static let virusFollowRange: CGFloat = 100.0
    static let spriteSizeShrinkMultiplier: CGFloat = 0.96
    static let spriteSizeShrinkThreshold: CGFloat = 0.1
    static let virusScaleFactor: CGFloat = 0.15
    static let gridColumnHeight: CGFloat = 60.0
    static let gridNumColumns: Int = 6
    static let gridNumRows: Int = 500
    static let gameItemPhysicsRadius: CGFloat = 0.4
    static let healthMeterPadding: CGFloat = 60.0
    static let scoreLabelPadding: CGFloat = 50.0
    static let roundLabelPadding: CGFloat = 70.0
    static let pointValueSilverPiece: UInt = 15
    static let pointValueGoldPiece: UInt = 35
    static let basePointValueEmerald: UInt = 50
    static let basePointValueRuby: UInt = 100
    static let pointLabelFadeMultiplier: CGFloat = 0.99
    static let pointLabelVelocity: CGFloat = 0.8
    static let pointLabelAlphaThreshold: CGFloat = 0.3
    static let forceFieldScaleConstant: CGFloat = 0.6
    static let forceFieldUpgradePrice: UInt = 800
    static let cycloneUpgradePrice: UInt = 800
    static let menuLabelFontSize: CGFloat = 14.0
    static let upgradePrice: Decimal = 0.99
    static let scoreLabelPrefix = "SCORE: "
    static let roundLabelPrefix = "ROUND: "

}
struct GameSceneVars {
    var bat = Bat()
    var grid = Grid()
    var forceField = ForceField()
    var forceFieldDashboard = ForceFieldDashboardIndicator()
    var cyclone = Cyclone()
    var cycloneDashboard = CycloneDashboardIndicator()
    var healthMeter = HealthMeter()
    var countdownAnnouncer = AnnouncerCountdown()
    var roundCompleteAnnouncer = AnnouncerRoundCompleted()
    var upgradeButton = SKSpriteNode(imageNamed: "StoreButton")
    var gameInProgress: Bool = false
    var forceFieldReserve: UInt = 2
    var cycloneReserve: UInt = 2
    var cycloneDeployed: Bool = false
    var forceFieldDeployed: Bool = false
    var backLayer = SKNode()
    var score: UInt = 0
    var round: UInt = 1
    var persistenceCounter: UInt = 0
    var background = SKSpriteNode(imageNamed: "Background_Cropped")
    var pauseButton =  SKSpriteNode(imageNamed: "PauseButton")
    var gameOver = SKSpriteNode(imageNamed: "GameOver")
    var isCountingDown: Bool = true
    var countdownCounter: Int = 240
    var gamePausedState: Int = 1
    var gameOverbouncingBack: Bool = false
    var gameOverBackLayerDisplacement: CGFloat = 400.0
    var blackBar = SKSpriteNode(color: UIColor.black, size: CGSize.zero)
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var batDeathBackgroundVelocity: CGFloat = 0.0
    var skullFollowSpeed: CGFloat = 2.4
    var screenTouched = false
    var currentlyCapturedItem: SKSpriteNode?
    var currentTouchLocation: CGPoint?
    var buzzerSoundEffect: AVAudioPlayer?
    var treasureSoundEffect: AVAudioPlayer?
    var coinSoundEffect: AVAudioPlayer?
    var backgroundMusicPlayer: AVAudioPlayer?
    var columnHalfWidth: CGFloat = 0.0
    var columnHeight: CGFloat = 60.0
    var roundEndPosition: CGFloat = 10000.0
    var scoreLabel = SKLabelNode()
    var roundLabel = SKLabelNode()
    var pointsLabels = [String: SKLabelNode]()
    var virusOccurenceLowerLimit: UInt = 80
    var skullOccurenceLowerLimit: UInt = 85

    mutating func setScreenDimensions(_ width: CGFloat, _ height: CGFloat) {
        screenWidth = width
        screenHeight = height
    }

}

final class GameScene: SKScene {
    weak var gameSceneDelegate: GameSceneDelegate?
    var gameVars = GameSceneVars()
    var varsInitialValues = GameSceneVars()
    private let soundManager = SoundManager.shared
    let defaults = UserDefaults.standard
    private var textureCache: [String: SKTexture] = [:]
    private let textureQueue = DispatchQueue(label: "com.ghostdodger.textureloading")
    // Audio system
    let gameAudioEngine = AVAudioEngine()
    var gameSoundPlayers = [String: AVAudioPlayer]()
    var lastUpdateTime: TimeInterval = 0
    let minimumFrameInterval: TimeInterval = 1.0 / 60.0 // Target 60 FPS

    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gameSetup()
        configurePhysicsWorld()
        setupAudioEngine()
        playGameSceneBackgroundMusic()
    }

    func setupAudioEngine() {
        let soundMappings: [(name: String, volume: Float)] = [
            ("Coin01.mp3", GameSceneConstants.coinSoundEffectVolume),
            ("Buzzer.mp3", GameSceneConstants.buzzerSoundEffectVolume),
            ("Treasure.mp3", 1.0),
            ("VirusDodger_GameScene.mp3", 0.4)
        ]
        
        let players = soundManager.preloadSounds(soundMappings)
        
        // Set the appropriate game variable reference
        gameVars.coinSoundEffect = players["Coin01.mp3"]
        gameVars.buzzerSoundEffect = players["Buzzer.mp3"]
        gameVars.treasureSoundEffect = players["Treasure.mp3"]
        gameVars.backgroundMusicPlayer = players["VirusDodger_GameScene.mp3"]
    }

    func playGameSceneBackgroundMusic() {
        soundManager.playBackgroundMusic(gameVars.backgroundMusicPlayer)
    }

    func playSound(_ player: AVAudioPlayer?) {
        soundManager.playSound(player)
    }

}
