
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
        // 1. Basecase: If both nodes are nil, we have equality
        if p == nil && q == nil {
            return true
        }
        // 2. Basecase: We have inequality, if either one of the nodes is nil but the other isnt, or if the values of the nodes are unequal. Then we return false
        if p == nil || q == nil || p?.val != q?.val {
            return false
        }
        // if both of the base cases were not true, we deduce that both of our nodes do have a value and are equal
        return (self.isSameTree(p?.left, q?.left) && self.isSameTree(p?.right, q?.right))
    }
    
 
    // MARK: - 94. Binary Tree Inorder Traversal
    
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
            guard let root = root else { return [] }
        // 1. We are traversing the left side of the nodes until we reach nil
        // 2. Once we reached nil, we add the root value to the array
        // 3. Then we do the same with the right node
            return inorderTraversal(root.left) + [root.val] + inorderTraversal(root.right)
        }
    
    // MARK: - 572. Subtree of another Tree
    
    func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
        // t denotes the root node of the subtree, s the root node of the tree
        // if t is nil, it is technically a subtree of s, irrespective of what s is
            if t == nil { return true }
        // if we passed the first statement, we deduce that t is not nil. So t is not nil
        // but s is nil, so t cant be a subtree of s
            if s == nil { return false }
        // since we pased the first two statements, we know that both tree roots have a value
        // we test if the trees are identical, if they are we return true
            if isIdentical(first: s, second: t) { return true }
        // if isIdentical returned false, we want to see whether the same tree (the t tree) is found alongside
        // the left side and the right side of the s tree. If the tree is found on either the left or
        // the ride side, we return true
        // think about the fact that all we are doing is just calling isIdentical function on the left and right,
        // looking whether the tree is found on either side (and testing the base cases).
            return isSubtree(s?.left, t) ||
                    isSubtree(s?.right, t)
        }
        
        private func isIdentical(first: TreeNode?, second: TreeNode?) -> Bool {
            if first == nil, second == nil { return true }
            if first == nil || second == nil { return false }
            
            if first?.val == second?.val,
                isIdentical(first: first?.left, second: second?.left),
                isIdentical(first: first?.right, second: second?.right) {
                return true
            }
            return false
        }
    
    
    // MARK: - 108. Convert Sorted Array to Binary Search Tree

        func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
            if nums.count == 0 {
                return nil
            }
            
            return helper(nums, 0, nums.count - 1)
        }
        
        func helper(_ nums: [Int], _ low: Int, _ high: Int) -> TreeNode? {
            // thats the base case
            if low > high {
                return nil
            }
            // get the middle of the array
            let middle = (low + high) / 2
            // create a node with the middle
            let node = TreeNode(val: nums[middle])
            // run helper recursively on the left side of the array
            node.left = helper(nums, low, middle - 1)
            // run helper recursively on the right side of the array
            node.right = helper(nums, middle + 1, high)
            
            return node
        }
    
    
    // MARK: - 617. Merge two binary trees
    
    func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
        // Our base case: The only time when we want to return nil is when both nodes are nil.
        // If one node is nil while the other isn't, we just want to add those two up
        if t1 == nil, t2 == nil { return nil }
        // We passed first statement, meaning both nodes aren't nil. So now either both have a value and
        // can be added together, or one of them is nil. If one of them is nil, we substitute it with 0
        // so we can conduct addition
        let root = TreeNode(val: (t1?.val ?? 0) + (t2?.val ?? 0))
        // recursion on left subtree
        root.left = mergeTrees(t1?.left, t2?.left)
        // recursion on right subtree
        root.right = mergeTrees(t1?.right, t2?.right)
        return root
    }

    
    // MARK: - 112. Path Sum
    
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        guard let root = root else {
            return false
        }
        
        if root.left == nil && root.right == nil {
            return root.val == sum
        }
        return hasPathSum(root.left, sum - root.val) || hasPathSum(root.right, sum - root.val)
    }
    
    
    // MARK: - 226. Invert binary tree
    
    func invertTree2(_ root: TreeNode?) -> TreeNode? {
        // base case
        guard root != nil else { return nil }
        
        invertTree2(root?.left)
        invertTree2(root?.right)
        // at this point, we are now one level above the base case
        // Regarding the example 1, we would be at node 2 now
        // Now, we want to swap the pointers
        let hold = root?.left
        root?.left = root?.right
        root?.right = hold
        
        return root
        
    }
    
}






