//
//  UpgradesController.swift
//  KillVirus
//
//  Created by Jeremy Bringetto on 11/3/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

protocol UpgradesControllerDelegate:AnyObject {
    func receiveVarsUpdate(newVars:GameSceneVars)->Void
}

class UpgradesController: UIViewController, UpgradesSceneDelegate {

    weak var delegate:UpgradesControllerDelegate?
    @IBOutlet weak var upgradeView: SKView!
    var scene = UpgradeScene()
    var gameVars:GameSceneVars?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scene = UpgradeScene.init(size: upgradeView.frame.size)
        scene.upgradeVars.setScreenDimensions(UIScreen.main.bounds.width,UIScreen.main.bounds.height)
        scene.scaleMode = .resizeFill
        //scene.backgroundColor = .init(red:0.65, green:0.32, blue:0.00, alpha:1.0)
        scene.backgroundColor = UIColor.black
        scene.gameVars = gameVars
        scene.varsDelegate = self
        upgradeView.showsFPS = true
        upgradeView.ignoresSiblingOrder = false
        upgradeView.presentScene(scene)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
          self.navigationController?.setNavigationBarHidden(false, animated: false)
     }
   func showUpgradeAlert(upgradeType:UpgradeType)->Void
    {
        
        let alertTitle = titleForUpgradeType(upgradeType)
        let alertMessage = messageForUpgradeType(upgradeType)
        let alert = UIAlertController.init(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        alert.addAction(cancelAction)
        switch(upgradeType) {
        case .cyclone :
            let cycloneAction = UIAlertAction(title: "Buy", style: .default, handler: { [weak self]  action in
                self?.scene.buyCyclone()
            })
            alert.addAction(cycloneAction)
                
        case .forceField :
            let forceFieldAction = UIAlertAction(title: "Buy", style: .default, handler: { [weak self]  action in
                self?.scene.buyForceField()
            })
            alert.addAction(forceFieldAction)
        
        }
    
       self.present(alert, animated: false, completion: nil)
    }
    func titleForUpgradeType(_ upgradeType:UpgradeType)->String {
        var title = "Buy "
        if upgradeType == .cyclone {
            title += "Cyclone Upgrade?"
        } else if upgradeType == .forceField {
            title += "Force Field Upgrade?"
            
        }
        return title
    }
    func messageForUpgradeType(_ upgradeType:UpgradeType)->String {
        
        var price:UInt = 0
        var message = "Would you like to buy a single-use thirty second consumable "
        if upgradeType == .cyclone {
            message += "cyclone "
            price = GameSceneConstants.cycloneUpgradePrice
        } else if upgradeType == .forceField {
            message += "force field "
            price = GameSceneConstants.forceFieldUpgradePrice
            
        }
        message += "upgrade for \(price) points?"
        return message
    }
    // MARK: - UpgradesSceneDelegate

    func updateVars(newVars: GameSceneVars) {
        self.delegate?.receiveVarsUpdate(newVars: newVars)
    }


}
