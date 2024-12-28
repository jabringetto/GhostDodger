import SpriteKit
import AVFoundation

class EnterScene: SKScene {
    private var assetsLoaded = false
    
    override func didMove(to view: SKView) {
        // Start with loading scene
        let loadingScene = LoadingScene(size: self.size)
        loadingScene.scaleMode = .aspectFill
        view.presentScene(loadingScene)
        
        // Load assets asynchronously
        loadAssetsAsync(loadingScene: loadingScene)
    }
    
    private func setupScene() {
        // Setup How To Play button
        let howToPlayButton = SKLabelNode(text: "How To Play")
        howToPlayButton.fontSize = 30
        howToPlayButton.position = CGPoint(x: size.width/2, y: size.height * 0.4)
        howToPlayButton.name = "howToPlayButton"
        addChild(howToPlayButton)
    }
    
    private func loadAssetsAsync(loadingScene: LoadingScene) {
        DispatchQueue.global(qos: .userInitiated).async {
            // Count total assets for progress calculation
            let totalAssets = self.countTotalAssets()
            var loadedAssets = 0
            
            // Preload textures
            self.preloadTextures { 
                loadedAssets += 1
                self.updateProgress(loadedAssets, total: totalAssets, loadingScene: loadingScene)
            }
            
            // Preload audio
            self.preloadAudio {
                loadedAssets += 1
                self.updateProgress(loadedAssets, total: totalAssets, loadingScene: loadingScene)
            }
            
            // When everything is loaded, switch to main scene
            DispatchQueue.main.async {
                self.assetsLoaded = true
                self.view?.presentScene(self, transition: .fade(withDuration: 0.5))
                self.setupScene()
            }
        }
    }
    
    private func updateProgress(_ current: Int, total: Int, loadingScene: LoadingScene) {
        DispatchQueue.main.async {
            loadingScene.progress = CGFloat(current) / CGFloat(total)
        }
    }
    
    private func countTotalAssets() -> Int {
        return 2 // Textures and Audio
    }
    
    private func preloadTextures(completion: @escaping () -> Void) {
        let textureAtlases = ["Bat", "Ghost", "Skull", "Virus", "VirusWithFace", "ForceField"]
        let group = DispatchGroup()
        
        for atlasName in textureAtlases {
            group.enter()
            let atlas = SKTextureAtlas(named: atlasName)
            atlas.preload {
                group.leave()
            }
        }
        
        group.notify(queue: .global()) {
            completion()
        }
    }
    
    private func preloadAudio(completion: @escaping () -> Void) {
        let soundNames = ["Coin01", "Buzzer", "Kaching", "Treasure", "VirusDodger_GameScene"]
        let group = DispatchGroup()
        
        for soundName in soundNames {
            group.enter()
            if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.prepareToPlay()
                    group.leave()
                } catch {
                    print("Could not load sound: \(soundName)")
                    group.leave()
                }
            } else {
                group.leave()
            }
        }
        
        group.notify(queue: .global()) {
            completion()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        
        for node in nodes {
            if node.name == "howToPlayButton" {
                if let howToPlayScene = HowToPlayScene(size: self.size) {
                    howToPlayScene.scaleMode = .aspectFill
                    self.view?.presentScene(howToPlayScene, transition: .fade(withDuration: 0.5))
                }
            }
            // ... existing touch handling code ...
        }
    }
} 