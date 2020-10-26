//
//  AnnouncerRoundCompleted.swift
//  VirusDodger
//
//  Created by Jeremy Bringetto on 6/21/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import SpriteKit

protocol AnnouncerRoundCompletedDelegate:class
{
    
    func currentRoundNumber()->UInt
}

class AnnouncerRoundCompleted: SKSpriteNode
{
      weak var delegate:AnnouncerRoundCompletedDelegate?
      var playButton = SKSpriteNode(imageNamed: "PlayButton")
      var completedLabel = SKLabelNode(fontNamed:"Arial")
    
      init()
      {
        let texture = SKTexture(imageNamed: "Announcer")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        configureLabels()
        addPlayButton()
      }
       required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
    func setCompletedLabelText()->Void
    {
        guard let roundNum:UInt = self.delegate?.currentRoundNumber() else {return}
        completedLabel.text = "Round \(roundNum) Completed!"
    }
     private func configureLabels()
     {
        completedLabel.fontColor = UIColor(hex: "#D5BF9DFF")
        completedLabel.fontSize = self.size.width * 0.09
        completedLabel.position.y = self.size.height * 0.30
        self.addChild(completedLabel)
     }
     private func addPlayButton()->Void
     {
        playButton.name = "roundCompletedPlayButton"
        playButton.xScale = 2.2
        playButton.yScale = 2.2
        self.addChild(playButton)
        
     }
    
     
}
