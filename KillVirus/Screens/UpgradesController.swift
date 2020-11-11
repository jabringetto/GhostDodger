//
//  UpgradesController.swift
//  KillVirus
//
//  Created by Jeremy Bringetto on 11/3/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

class UpgradesController: UIViewController {

    @IBOutlet weak var upgradeView: SKView!
    var scene = UpgradeScene()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scene = UpgradeScene.init(size: upgradeView.frame.size)
        scene.upgradeVars.setScreenDimensions(UIScreen.main.bounds.width,UIScreen.main.bounds.height)
        scene.scaleMode = .resizeFill
        //scene.backgroundColor = .init(red:0.65, green:0.32, blue:0.00, alpha:1.0)
        scene.backgroundColor = UIColor.black
        upgradeView.showsFPS = true
        upgradeView.presentScene(scene)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
          self.navigationController?.setNavigationBarHidden(false, animated: false)
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
