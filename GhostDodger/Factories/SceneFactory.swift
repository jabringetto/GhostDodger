protocol SceneFactory {
    func createLoadingScene(size: CGSize) -> LoadingScene
    func createGameScene(size: CGSize) -> GameScene
    func createEnterScene(size: CGSize) -> EnterScene
}

class GameSceneFactory: SceneFactory {
    private let assetLoader: AssetLoadingService
    
    init(assetLoader: AssetLoadingService) {
        self.assetLoader = assetLoader
    }
    
    func createLoadingScene(size: CGSize) -> LoadingScene {
        let scene = LoadingScene(size: size)
        scene.scaleMode = .aspectFill
        return scene
    }
    
    // Implement other scene creation methods
} 