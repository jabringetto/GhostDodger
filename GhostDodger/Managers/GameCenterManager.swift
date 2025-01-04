import GameKit

final class GameCenterManager {
    static let shared = GameCenterManager()
    private let leaderboardID = "com.ghostdodger.highscore"
    private var isAuthenticated = false
    
    private init() {
        authenticatePlayer()
    }
    
    func authenticatePlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { [weak self] viewController, error in
            if let error = error {
                print("Game Center authentication error: \(error.localizedDescription)")
                return
            }
            
            if let viewController = viewController {
                // Present authentication view controller if needed
                NotificationCenter.default.post(
                    name: NSNotification.Name("PresentGameCenterAuth"),
                    object: viewController
                )
            } else {
                self?.isAuthenticated = true
                print("Player authenticated with Game Center")
            }
        }
    }
    
    func submitScore(_ score: Int, completion: ((Error?) -> Void)? = nil) {
        guard isAuthenticated else {
            completion?(NSError(domain: "GameCenter", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not authenticated"]))
            return
        }
        
        let scoreReporter = GKScore(leaderboardIdentifier: leaderboardID)
        scoreReporter.value = Int64(score)
        
        GKScore.report([scoreReporter]) { error in
            if let error = error {
                print("Error submitting score: \(error.localizedDescription)")
            }
            completion?(error)
        }
    }
    
    func showLeaderboard(from viewController: UIViewController) {
        guard isAuthenticated else { return }
        
        let gcViewController = GKGameCenterViewController(state: .leaderboards)
        gcViewController.gameCenterDelegate = viewController as? GKGameCenterControllerDelegate
        viewController.present(gcViewController, animated: true)
    }
} 