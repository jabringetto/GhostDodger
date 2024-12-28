import SpriteKit

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
    
    func createGameScene(size: CGSize) -> GameScene {
        let scene = GameScene(size: size)
        scene.scaleMode = .resizeFill
        return scene
    }
    
    func createEnterScene(size: CGSize) -> EnterScene {
        let scene = EnterScene(size: size)
        scene.scaleMode = .aspectFill
        return scene
    }
} 