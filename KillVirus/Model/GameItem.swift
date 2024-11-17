//
//  GameItem.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 1/16/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit

enum GameItemType: Int {
    case none

    case ruby

    case emerald

    case silverCoin

    case goldCoin
    
    case ghost

    case skull

    case virus
}
struct PositionAndType: Codable {
    let position: CGPoint
    let type: Int
}
final class GameItem: SKNode {

    var itemType: GameItemType?
    var itemSprite: SKSpriteNode?
    var pointValue: Int = 0

    convenience init(type: GameItemType, sprite: SKSpriteNode?) {
           self.init()
           self.itemType = type
           self.itemSprite = sprite
    }

}

extension UIColor {
    public convenience init?(hex: String) {
        let red, green, blue, alpha: CGFloat // swiftlint:disable:this
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    red  = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    blue  = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    alpha = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }

        return nil
    }
}
