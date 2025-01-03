import UIKit
import SwiftUI
import GameKit

protocol GameOverHostingControllerDelegate: AnyObject {
    func gameOverHostingControllerDidRequestPlayAgain(_ controller: GameOverHostingController)
}

class GameOverHostingController: UIHostingController<GameOverView>, GKGameCenterControllerDelegate {
    weak var delegate: GameOverHostingControllerDelegate?
    
    init(score: UInt) {
        var rootView = GameOverView(
            score: score,
            onSubmitScore: { },  // Handled directly in GameOverView
            onViewLeaderboard: { },  // Will be set after init
            onPlayAgain: { }
        )
        super.init(rootView: rootView)
        
        // Update closures after init
        rootView.onViewLeaderboard = { [weak self] in
            guard let self = self else { return }
            let gcViewController = GKGameCenterViewController(state: .leaderboards)
            gcViewController.gameCenterDelegate = self
            self.present(gcViewController, animated: true)
        }
        
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
