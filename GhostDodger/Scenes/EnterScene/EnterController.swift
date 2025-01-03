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
    let soundManager = EnterSoundManager.shared
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
        scene.enterSceneDelegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        soundManager.stopEnterBackgroundMusic()
    }
    
    // MARK: Background Music
    
    private func addBackgroundMusic() {
        soundManager.playEnterBackgroundMusic()
    }

}

extension EnterViewController: EnterSceneDelegate {
    func didPressEnterButton() {
        performSegue(withIdentifier: "howToSegue", sender: self)
    }
}
