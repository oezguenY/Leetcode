
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
    
    
    
}



