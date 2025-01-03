import UIKit
import SwiftUI
import GameKit

protocol GameOverHostingControllerDelegate: AnyObject {
    func gameOverHostingControllerDidRequestPlayAgain(_ controller: GameOverHostingController)
}

class GameOverHostingController: UIHostingController<GameOverView>, GKGameCenterControllerDelegate {
    weak var delegate: GameOverHostingControllerDelegate?
    
    init(score: UInt) {
        super.init(rootView: GameOverView(
            score: score,
            onSubmitScore: { },  // Handled directly in GameOverView
            onViewLeaderboard: {
                GameCenterManager.shared.showLeaderboard(from: UIApplication.shared.windows.first?.rootViewController ?? UIViewController())
            },
            onPlayAgain: { }
        ))
        
        // Update closure after init since we need self
        rootView.onPlayAgain = { [weak self] in
            guard let self = self else { return }
            self.delegate?.gameOverHostingControllerDidRequestPlayAgain(self)
        }
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        view.backgroundColor = .clear
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - GKGameCenterControllerDelegate
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
} 