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
    
    var score: UInt = 0 {
        didSet {
            defaults.set(score, forKey: "score")
        }
    }
    
    var round: UInt = 1 {
        didSet {
            defaults.set(round, forKey: "round")
        }
    }
    
    var isGameOver: Bool = false {
        didSet {
            defaults.set(isGameOver, forKey: "isGameOver")
        }
    }
    
    var isPaused: Bool = false {
        didSet {
            defaults.set(isPaused, forKey: "isPaused")
        }
    }
    
    func save() {
        defaults.synchronize()
    }
    
    func load() {
        score = UInt(defaults.integer(forKey: "score"))
        round = UInt(defaults.integer(forKey: "round"))
        isGameOver = defaults.bool(forKey: "isGameOver")
        isPaused = defaults.bool(forKey: "isPaused")
    }
    
    func reset() {
        score = 0
        round = 1
        isGameOver = false
        isPaused = false
        save()
    }
} 