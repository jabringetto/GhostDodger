//
//  GameSprite.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 10/25/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import Foundation
import SpriteKit

protocol ConvergeAndShrinkDelegate: AnyObject {

    func shrinkCompleted(sprite: SKSpriteNode)
}

class GameSprite: SKSpriteNode {
    var convergingOnCyclone = false
    weak var delegate: ConvergeAndShrinkDelegate?

}
