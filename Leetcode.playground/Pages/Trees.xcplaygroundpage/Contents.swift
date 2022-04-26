
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
}
// [4,2,7,1,3,6,9]



