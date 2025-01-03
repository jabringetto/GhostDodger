import UIKit
import SwiftUI
import GameKit

protocol GameOverHostingControllerDelegate: AnyObject {
    func gameOverHostingControllerDidRequestPlayAgain(_ controller: GameOverHostingController)
}

class GameOverViewModel: ObservableObject {
    let score: UInt
    var onViewLeaderboard: () -> Void = { }
    var onPlayAgain: () -> Void = { }
    
    init(score: UInt) {
        self.score = score
    }
}

class GameOverHostingController: UIHostingController<GameOverView>, GKGameCenterControllerDelegate {
    weak var delegate: GameOverHostingControllerDelegate?
    private let viewModel: GameOverViewModel
    
    init(score: UInt) {
        let viewModel = GameOverViewModel(score: score)
        self.viewModel = viewModel
        
        let rootView = GameOverView(
            score: score,
            onSubmitScore: { },  // Handled directly in GameOverView
            onViewLeaderboard: { [weak viewModel] in
                viewModel?.onViewLeaderboard()
            },
            onPlayAgain: { [weak viewModel] in
                viewModel?.onPlayAgain()
            }
        )
        super.init(rootView: rootView)
        
        // Set up view model actions
        viewModel.onViewLeaderboard = { [weak self] in
            guard let self = self else { return }
            let gcViewController = GKGameCenterViewController(state: .leaderboards)
            gcViewController.gameCenterDelegate = self
            self.present(gcViewController, animated: true)
        }
        
        viewModel.onPlayAgain = { [weak self] in
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
