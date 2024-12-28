import SpriteKit

class HowToPlayScene: SKScene {
    
    private var currentPage = 0
    private let totalPages = 3
    private var pageNodes: [SKNode] = []
    
    // UI Elements
    private var nextButton: SKLabelNode!
    private var prevButton: SKLabelNode!
    private var playButton: SKLabelNode!
    private var pageControl: SKNode!
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupButtons()
        setupPages()
        setupPageControl()
        showCurrentPage()
    }
    
    private func setupBackground() {
        let background = SKSpriteNode(color: .black, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = -1
        addChild(background)
    }
    
    private func setupButtons() {
        // Next button
        nextButton = SKLabelNode(text: "→")
        nextButton.fontSize = 40
        nextButton.position = CGPoint(x: size.width * 0.9, y: size.height * 0.1)
        nextButton.name = "nextButton"
        addChild(nextButton)
        
        // Previous button
        prevButton = SKLabelNode(text: "←")
        prevButton.fontSize = 40
        prevButton.position = CGPoint(x: size.width * 0.1, y: size.height * 0.1)
        prevButton.name = "prevButton"
        prevButton.isHidden = true
        addChild(prevButton)
        
        // Play button
        playButton = SKLabelNode(text: "Play!")
        playButton.fontSize = 40
        playButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        playButton.name = "playButton"
        playButton.isHidden = true
        addChild(playButton)
    }
    
    private func setupPages() {
        // Page 1: Bat Controls
        let page1 = createTutorialPage(
            title: "Control Your Bat",
            description: "Tap and drag anywhere to move",
            demonstrationNode: createBatDemonstration()
        )
        
        // Page 2: Avoid Ghosts
        let page2 = createTutorialPage(
            title: "Dodge the Ghosts",
            description: "Don't let them catch you!",
            demonstrationNode: createGhostDemonstration()
        )
        
        // Page 3: Collect Points
        let page3 = createTutorialPage(
            title: "Collect Points",
            description: "Grab coins and power-ups",
            demonstrationNode: createCollectiblesDemonstration()
        )
        
        pageNodes = [page1, page2, page3]
        pageNodes.forEach { addChild($0) }
    }
    
    private func createTutorialPage(title: String, description: String, demonstrationNode: SKNode) -> SKNode {
        let page = SKNode()
        
        let titleLabel = SKLabelNode(text: title)
        titleLabel.fontSize = 36
        titleLabel.position = CGPoint(x: 0, y: size.height * 0.3)
        
        let descLabel = SKLabelNode(text: description)
        descLabel.fontSize = 24
        descLabel.position = CGPoint(x: 0, y: size.height * 0.2)
        
        demonstrationNode.position = CGPoint(x: 0, y: 0)
        
        page.addChild(titleLabel)
        page.addChild(descLabel)
        page.addChild(demonstrationNode)
        
        page.position = CGPoint(x: size.width/2, y: size.height/2)
        page.isHidden = true
        
        return page
    }
    
    private func setupPageControl() {
        pageControl = SKNode()
        let dotSpacing: CGFloat = 20
        
        for i in 0..<totalPages {
            let dot = SKShapeNode(circleOfRadius: 5)
            dot.position = CGPoint(x: CGFloat(i) * dotSpacing - (dotSpacing * CGFloat(totalPages-1))/2, y: 0)
            dot.fillColor = i == 0 ? .white : .gray
            dot.strokeColor = .clear
            pageControl.addChild(dot)
        }
        
        pageControl.position = CGPoint(x: size.width/2, y: size.height * 0.15)
        addChild(pageControl)
    }
    
    private func showCurrentPage() {
        pageNodes.enumerated().forEach { index, page in
            page.isHidden = index != currentPage
        }
        
        prevButton.isHidden = currentPage == 0
        nextButton.isHidden = currentPage == totalPages - 1
        playButton.isHidden = currentPage != totalPages - 1
        
        pageControl.children.enumerated().forEach { index, node in
            if let dot = node as? SKShapeNode {
                dot.fillColor = index == currentPage ? .white : .gray
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        
        for node in nodes {
            switch node.name {
            case "nextButton":
                if currentPage < totalPages - 1 {
                    currentPage += 1
                    showCurrentPage()
                }
            case "prevButton":
                if currentPage > 0 {
                    currentPage -= 1
                    showCurrentPage()
                }
            case "playButton":
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    gameScene.scaleMode = .aspectFill
                    self.view?.presentScene(gameScene, transition: .fade(withDuration: 0.5))
                }
            default:
                break
            }
        }
    }
    
    // MARK: - Demonstration Nodes
    
    private func createBatDemonstration() -> SKNode {
        let demo = SKNode()
        let bat = SKSpriteNode(imageNamed: "bat") // Use your actual bat asset
        bat.size = CGSize(width: 50, height: 50)
        
        // Add animation to show bat movement
        let moveRight = SKAction.moveBy(x: 100, y: 0, duration: 1)
        let moveLeft = SKAction.moveBy(x: -100, y: 0, duration: 1)
        let sequence = SKAction.sequence([moveRight, moveLeft])
        bat.run(SKAction.repeatForever(sequence))
        
        demo.addChild(bat)
        return demo
    }
    
    private func createGhostDemonstration() -> SKNode {
        let demo = SKNode()
        let ghost = SKSpriteNode(imageNamed: "ghost") // Use your actual ghost asset
        ghost.size = CGSize(width: 50, height: 50)
        
        // Add animation to show ghost behavior
        let moveDown = SKAction.moveBy(x: 0, y: -50, duration: 1)
        let moveUp = SKAction.moveBy(x: 0, y: 50, duration: 1)
        let sequence = SKAction.sequence([moveDown, moveUp])
        ghost.run(SKAction.repeatForever(sequence))
        
        demo.addChild(ghost)
        return demo
    }
    
    private func createCollectiblesDemonstration() -> SKNode {
        let demo = SKNode()
        let coin = SKSpriteNode(imageNamed: "coin") // Use your actual coin asset
        coin.size = CGSize(width: 30, height: 30)
        
        // Add spinning animation
        let spin = SKAction.rotate(byAngle: .pi * 2, duration: 1)
        coin.run(SKAction.repeatForever(spin))
        
        demo.addChild(coin)
        return demo
    }
} 