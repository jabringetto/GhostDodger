protocol GameState {
    var score: UInt { get set }
    var round: UInt { get set }
    var isGameOver: Bool { get set }
    var isPaused: Bool { get set }
    
    func save()
    func load()
    func reset()
}

class GameStateManager: GameState {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    // Implement protocol methods
} 