//
//  EnterViewController.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 12/22/18.
//  Copyright © 2018 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

final class EnterViewController: UIViewController {

    @IBOutlet weak var enterView: SKView!

    var scene = EnterScene()
    private let soundManager = SoundManager.shared
    var sceneVars = EnterSceneVars()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        scene = EnterScene.init(size: enterView.frame.size)
        scene.sceneVars.setScreenDimensions(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        scene.scaleMode = .resizeFill
        scene.backgroundColor = UIColor.black
        enterView.presentScene(scene)
        addBackgroundMusic()

    }

    @IBAction func enterButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "howToSegue", sender: self)
    }
    
    private func addBackgroundMusic() {
        sceneVars.enterMusicPlayer = soundManager.loadSound("VirusDodger_EnterScene.mp3", volume: 0.5)
        soundManager.playBackgroundMusic(sceneVars.enterMusicPlayer)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        soundManager.stopBackgroundMusic(sceneVars.enterMusicPlayer)
    }

}
