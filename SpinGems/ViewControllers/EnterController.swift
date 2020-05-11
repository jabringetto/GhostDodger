//
//  EnterViewController.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 12/22/18.
//  Copyright © 2018 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

class EnterViewController: UIViewController {

    
    @IBOutlet weak var enterView: SKView!

    var scene = EnterScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view, typically from a nib.
 
        scene = EnterScene.init(size: enterView.frame.size)
        //scene.gameVars.setScreenDimensions(UIScreen.main.bounds.width,UIScreen.main.bounds.height)
        scene.scaleMode = .resizeFill
        //scene.backgroundColor = .init(red:0.65, green:0.32, blue:0.00, alpha:1.0)
        scene.backgroundColor = UIColor.black
        enterView.presentScene(scene)
    
          
    }


}

