//
//  GameScene_Touches.swift
//  SpinGems
//
//  Created by Jeremy Bringetto on 1/24/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
     {
         gameVars.screenTouched = true
         let touch = touches.first!
         let location = touch.location(in:self)
         gameVars.currentTouchLocation = location
     }
     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
     {
         
         let touch = touches.first!
         let location = touch.location(in:self)
         gameVars.currentTouchLocation = location
         
     }
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first!
         let location = touch.location(in:self)
         gameVars.currentTouchLocation = location
     }

    
}