// Add a node pooling system
final class NodePool {
    private var inactiveNodes: [SKSpriteNode] = []
    private let maximumSize: Int
    
    init(maximumSize: Int = 50) {
        self.maximumSize = maximumSize
    }
    
    func dequeue(withTexture texture: SKTexture) -> SKSpriteNode {
        if let node = inactiveNodes.popLast() {
            node.texture = texture
            node.isHidden = false
            return node
        }
        return SKSpriteNode(texture: texture)
    }
    
    func enqueue(_ node: SKSpriteNode) {
        guard inactiveNodes.count < maximumSize else { return }
        node.removeAllActions()
        node.isHidden = true
        node.removeFromParent()
        inactiveNodes.append(node)
    }
} 