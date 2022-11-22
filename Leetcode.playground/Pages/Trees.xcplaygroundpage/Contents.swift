
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
        // think about the fact that we will return an integer. This int
        // will be the longest distance from the root to the furthest leaf node
        // we are NOT returning booleans or whatever
        // let's say we are on the third level. So Maximum depth right now is 3
        // There is no left nor right node, so...
        guard root != nil else {
            // ...we return 0 and don't continue the recursion for that node.
            return 0
        }
        // think about the fact that every time we reach this line, we are on a new level
        // since we are on a new (deeper) level, we add 1. Now, if the left node of this
        // level's node is nil, we exit on line 41 by returning 0. On the other hand
        // if the left node is not nil, we recursively call this function on the left side again
        // and add 1 again. Same logic applies to the right side
        return 1 + max(maxDepthDFS(root?.left), maxDepthDFS(root?.right))
    }
    
    // MARK: - 543. Diameter of Binary Tree
    
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
       var result = 0
        
        func dfs(root: TreeNode?) -> Int? {
            guard root != nil else { return -1 }
            var left = dfs(root: root?.left)
            var right = dfs(root: root?.right)
            result = max(result, 2 + (left ?? 0) + (right ?? 0))
            
            // witht his line we choose the path (either left or right) which has
            // the most edges. Remember, our goal is to pick the path between two
            // nodes that have the most edges between them
            return 1 + max((left ?? 0), (right ?? 0))
        }
        dfs(root: root)
        return result
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

func maxDepthDFS2(_ root: TreeNode?) -> Int {
    // think about the fact that we will return an integer. This int
    // will be the longest distance from the root to the furthest leaf node
    // we are NOT returning booleans or whatever
    // let's say we are on the third level. So Maximum depth right now is 3
    // There is no left nor right node, so...
    guard root != nil else {
        // ...we return 0 and don't continue the recursion for that node.
        return 0
    }
    // think about the fact that every time we reach this line, we are on a new level
    // since we are on a new (deeper) level, we add 1. Now, if the left node of this
    // level's node is nil, we exit on line 41 by returning 0. On the other hand
    // if the left node is not nil, we recursively call this function on the left side again
    // and add 1 again. Same logic applies to the right side
    return 1 + max(maxDepthDFS2(root?.left), maxDepthDFS2(root?.right))
}

func invertBinaryTree2(_ root: TreeNode?) -> TreeNode? {
    
    guard root != nil else { return nil }
    
    invertBinaryTree2(root?.left)
    invertBinaryTree2(root?.right)
    
    let temp = root?.right
    root?.right = root?.left
    root?.left = temp
    
    return root
}

func inorderTraversal2(_ root: TreeNode?) -> [Int] {
    var result: [Int] = []
    
    func inOrder(_ root: TreeNode?) {
        guard root != nil else { return }
        inOrder(root?.left)
        result.append(root?.val ?? 0)
        inOrder(root?.right)
    }
    inOrder(root)
    return result
}


func maxDepth2(_ root: TreeNode?) -> Int {
    guard root != nil else { return 0 }
    
    return 1 + max(maxDepth2(root?.left), maxDepth2(root?.right))
}

func maxDepth3(_ root: TreeNode?) -> Int {
    guard root != nil else { return 0 }
    
    var left = maxDepth3(root?.left)
    var right = maxDepth3(root?.right)
    return max(left, right) + 1
}




