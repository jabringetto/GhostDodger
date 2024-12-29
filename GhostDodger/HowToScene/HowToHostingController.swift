//
//  HowToHostingController.swift
//  GhostDodger
//
//  Created by Jeremy Bringetto on 12/28/24.
//  Copyright © 2024 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SwiftUI

class HowToHostingController: UIViewController, HowToPlayViewDelegate {
    private let soundManager = SoundManager.shared
    let defaults = UserDefaults.standard
    var sceneVars = EnterSceneVars()
    private var howToPlayView: HowToPlayView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the SwiftUI view and hosting controller
        var howToPlayView = HowToPlayView()
        howToPlayView.delegate = self
        self.howToPlayView = howToPlayView
        
        let hostingController = UIHostingController(rootView: howToPlayView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        // Setup constraints
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        hostingController.didMove(toParent: self)
        
        addBackgroundMusic()
    }
    
    private func showGameInProgressAlert() {
        let alertMessage = "Our records indicate a saved game currently in progress. You may continue your saved game or discard and begin a new game."
        let alert = UIAlertController.init(title: "Game In Progress", message: alertMessage, preferredStyle: .actionSheet)
        let discardAction = UIAlertAction(title: "Discard", style: .cancel, handler: { [weak self] _ in
            self?.removeAllPersistence()
            self?.stopBackgroundMusic()
            self?.performSegue(withIdentifier: "enterGameSegue", sender: self)
        })
        let continueAction = UIAlertAction(title: "Continue", style: .default, handler: { [weak self] _ in
            self?.stopBackgroundMusic()
            self?.performSegue(withIdentifier: "enterGameSegue", sender: self)
        })
        alert.addAction(discardAction)
        alert.addAction(continueAction)
        self.present(alert, animated: false, completion: nil)
    }
    
    func didPressEnterButton() {
        let inProgress = defaults.object(forKey: "inProgress") as? Bool ?? false
        if inProgress {
            showGameInProgressAlert()
        } else {
            stopBackgroundMusic()
            self.performSegue(withIdentifier: "enterGameSegue", sender: self)
        }
    }

    // MARK: Persistence
    
    private func removePersisentValue(key: String) {
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    
    private func removeAllPersistence() {
        removePersisentValue(key: "score")
        removePersisentValue(key: "round")
        clearRoundPersistence()
    }
    private func clearRoundPersistence() {
        removePersisentValue(key: "inProgress")
        removePersisentValue(key: "positionData")
        removePersisentValue(key: "backLayerPositionY")
        removePersisentValue(key: "batPositionX")
        removePersisentValue(key: "batPositionY")
        removePersisentValue(key: "health")
        removePersisentValue(key: "forceFieldDeployed")
        removePersisentValue(key: "forceFieldTimer")
        removePersisentValue(key: "cycloneDeployed")
        removePersisentValue(key: "cycloneTimer")
        removePersisentValue(key: "cycloneReserve")
        removePersisentValue(key: "forceFieldReserve")
        
    }
    
    // MARK: Background Music
    
    private func addBackgroundMusic() {
        soundManager.playHowToHostingBackgroundMusic()
    }

    func stopBackgroundMusic() {
        soundManager.stopHowToHostingBackgroundMusic()
    }
    
    
    
}
