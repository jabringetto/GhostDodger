//
//  GameViewController.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 12/22/18.
//  Copyright © 2018 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    @IBOutlet weak var gameView: SKView!
    
    var scene = GameScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        scene = GameScene.init(size: gameView.frame.size)
        scene.gameVars.setScreenDimensions(UIScreen.main.bounds.width,UIScreen.main.bounds.height)
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .init(red:0.65, green:0.32, blue:0.00, alpha:1.0)
        gameView.presentScene(scene)
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
