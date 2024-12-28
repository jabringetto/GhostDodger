import SpriteKit

class LoadingScene: SKScene {
    private let loadingLabel = SKLabelNode(text: "Loading...")
    private let progressBar = SKShapeNode()
    private let progressFill = SKShapeNode()
    
    var progress: CGFloat = 0.0 {
        didSet {
            updateProgressBar()
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        // Setup loading label
        loadingLabel.fontSize = 32
        loadingLabel.position = CGPoint(x: size.width/2, y: size.height/2 + 50)
        addChild(loadingLabel)
        
        // Setup progress bar
        let barWidth: CGFloat = 200
        let barHeight: CGFloat = 20
        
        let barRect = CGRect(x: -barWidth/2, y: -barHeight/2, width: barWidth, height: barHeight)
        progressBar.path = CGPath(rect: barRect, transform: nil)
        progressBar.strokeColor = .white
        progressBar.lineWidth = 2
        progressBar.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(progressBar)
        
        progressFill.path = CGPath(rect: barRect, transform: nil)
        progressFill.fillColor = .white
        progressFill.position = progressBar.position
        progressFill.xScale = 0
        addChild(progressFill)
    }
    
    private func updateProgressBar() {
        progressFill.xScale = progress
    }
} 