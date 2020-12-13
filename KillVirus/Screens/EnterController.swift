//
//  EnterViewController.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 12/22/18.
//  Copyright © 2018 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

class EnterViewController: UIViewController {

    
    @IBOutlet weak var enterView: SKView!

    var scene = EnterScene()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view, typically from a nib.
 
        scene = EnterScene.init(size: enterView.frame.size)
        scene.sceneVars.setScreenDimensions(UIScreen.main.bounds.width,UIScreen.main.bounds.height)
        scene.scaleMode = .resizeFill
        //scene.backgroundColor = .init(red:0.65, green:0.32, blue:0.00, alpha:1.0)
        scene.backgroundColor = UIColor.black
        enterView.presentScene(scene)
    
          
    }
    func showGameInProgressAlert()->Void
    {
        let alert = UIAlertController.init(title: "Game In Progress", message: "Our records indicate a saved game currently in progress. You may continue your saved game or discard and begin a new game.", preferredStyle: .actionSheet)
        let discardAction = UIAlertAction(title: "Discard", style: .cancel, handler: { action in
            self.removeAllPersistence()
            self.performSegue(withIdentifier: "enterSegue", sender: self)
        })
        let continueAction = UIAlertAction(title: "Continue", style: .default, handler: { action in
             self.performSegue(withIdentifier: "enterSegue", sender: self)
        })
        alert.addAction(discardAction)
        alert.addAction(continueAction)
        self.present(alert, animated: false, completion: nil)
        
    }
    @IBAction func enterButtonPressed(_ sender: Any) {
        
        if let inProgress = defaults.object(forKey: "inProgress") as? Bool
        {
                if(inProgress)
                {
                    showGameInProgressAlert()
                }
                else
                {
                    self.performSegue(withIdentifier: "enterSegue", sender: self)
                }
        }
        self.performSegue(withIdentifier: "enterSegue", sender: self)
        
        
    }
    func removeAllPersistence()->Void
    {
        removePersisentValue(key:"score")
        removePersisentValue(key:"round")
        clearRoundPersistence()
    }
    func clearRoundPersistence()->Void
    {
        removePersisentValue(key:"inProgress")
        removePersisentValue(key: "positionData")
        removePersisentValue(key: "backLayerPositionY")
        removePersisentValue(key: "batPositionX")
        removePersisentValue(key: "batPositionY")
        removePersisentValue(key:"health")
        removePersisentValue(key: "forceFieldDeployed")
        removePersisentValue(key: "forceFieldTimer")
        removePersisentValue(key: "cycloneDeployed")
        removePersisentValue(key: "cycloneTimer")
        removePersisentValue(key: "cycloneReserve")
        removePersisentValue(key: "forceFieldReserve")

        
    }
    func removePersisentValue(key:String)->Void
    {
           defaults.removeObject(forKey:key)
           defaults.synchronize()
    }
    
}

