
import Foundation

// MARK: - Linked List Cycle 141

class ListNode {
     var val: Int
     var next: ListNode?
     init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    // - Complexity:
    //   - time: O(n), where n is the number of nodes in the linked list.
    //   - space: O(1), only constant space is used.

    func hasCycle(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head?.next
        
        while slow != nil, fast != nil {
            guard slow !== fast else { return true }
            
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        return false
    }
}




