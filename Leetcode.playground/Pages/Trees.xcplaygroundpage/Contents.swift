
import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
    
    // MARK: - 226. Invert Binary Tree
    
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        let temp = root?.left // 2
        root?.left = root?.right // 7
        root?.right = temp // 2
        
        self.invertTree(root?.left)
        self.invertTree(root?.right)
        return root
    }
    
    // MARK: - 104. Maximum Depth of Binary Tree
    
    func maxDepthDFS(_ root: TreeNode?) -> Int {
        return root != nil ? 1 + max(self.maxDepthDFS(root?.left), self.maxDepthDFS(root?.right)) : 0
    }
    // for every level in the tree, we add the nodes in a queue, loop and add 1 to the level
    func maxDepthBFS(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var maxLevel = 0
        var queue = [root] // 3
        while !queue.isEmpty {
            maxLevel += 1 // 1, 2, 3
            let count = queue.count // 1, 2, 2
            for _ in 0..<count { // 0, 0, 1, 0, 1
                let curr = queue.removeFirst() // []
                if let left = curr.left {
                    queue.append(left) // []
                }
                if let right = curr.right {
                    queue.append(right) // []
                }
            }
        }
        return maxLevel
    }
    
    // MARK: - 543. Diameter of Binary Tree
    
    func heightOfBinaryTree(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }
        return 1 + max(heightOfBinaryTree(node.left), heightOfBinaryTree(node.right));
    }
    
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }
        let hl = heightOfBinaryTree(node.left)
        let hr = heightOfBinaryTree(node.right)
        
        return max(hl + hr, max(diameterOfBinaryTree(node.left), diameterOfBinaryTree(node.right)))
    }
    
    // MARK: - 110. Balanced Binary Tree
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        return isBalancedTree(root).balanced
    }
    
    
    func isBalancedTree(_ node: TreeNode?) -> (height: Int, balanced: Bool) {
        guard let node = node else { return (-1, true) }
        
        let left = isBalancedTree(node.left)
        guard left.balanced else { return(-1, false) }
        
        let right = isBalancedTree(node.right)
        guard right.balanced else { return (-1, false) }
        
        guard abs(left.height - right.height) < 2 else { return (-1, false) }
        
        return (max(left.height, right.height) + 1, true)
    }
    
    // MARK: - 100. Same Tree
    
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        if p == nil || q == nil || p?.val != q?.val {
            return false
        }
        
        return (self.isSameTree(p?.left, q?.left) && self.isSameTree(p?.right, q?.right))
    }
    
    
    
}




