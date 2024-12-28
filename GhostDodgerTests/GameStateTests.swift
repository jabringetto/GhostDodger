class GameStateTests: XCTestCase {
    var sut: GameStateManager!
    var mockDefaults: UserDefaults!
    override func setUp() {
        super.setUp()
        mockDefaults = UserDefaults(suiteName: #file)
        sut = GameStateManager(defaults: mockDefaults)
    }

    func testScorePersistence() {
        sut.score = 100
        sut.save()

        let newState = GameStateManager(defaults: mockDefaults)
        newState.load()

        XCTAssertEqual(newState.score, 100)
    }
} 
