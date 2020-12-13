//
//  GameViewController.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 12/22/18.
//  Copyright © 2018 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameSceneDelegate, UpgradesControllerDelegate {

    

    @IBOutlet weak var gameView: SKView!
    
    var gameScene = GameScene()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        gameScene = GameScene.init(size: gameView.frame.size)
        gameScene.gameVars.setScreenDimensions(UIScreen.main.bounds.width,UIScreen.main.bounds.height)
        gameScene.scaleMode = .resizeFill
        gameScene.backgroundColor = .init(red:0.65, green:0.32, blue:0.00, alpha:1.0)
        gameScene.gameSceneDelegate = self
        gameView.presentScene(gameScene)
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        
      //  upgradeScene = UpgradeScene.init(size: gameView.frame.size)
       // upgradeScene.scaleMode = .resizeFill
       // upgradeScene.backgroundColor = .init(red:0.35, green:0.32, blue:0.10, alpha:1.0)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func displayUpgradeScene() {
    
        gameScene.pauseGame()
        performSegue(withIdentifier: "upgradeSegue", sender: self)

    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "upgradeSegue") {
            if let upgradeScreen = segue.destination as? UpgradesController {
                
                upgradeScreen.gameVars = gameScene.gameVars
                upgradeScreen.delegate = self
            }
        }
       
        
    }
    
    // MARK: UpgradesControllerDelegate
    func receiveVarsUpdate(newVars:GameSceneVars)->Void{
        gameScene.updateScoreAndReserveValues(newVars)
        
    }
    


}
