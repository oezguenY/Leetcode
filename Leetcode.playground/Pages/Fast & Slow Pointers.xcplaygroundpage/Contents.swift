
import Foundation


class ListNode {
     var val: Int
     var next: ListNode?
     init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    // MARK: - Linked List Cycle 141
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
    
    // MARK: - Linked List Cycle II 142
    
    func detectCycle(_ head: ListNode?) -> ListNode? {
        guard head?.next != nil else { return nil }
        var slow = head
        var fast = head

        while slow?.next != nil || fast?.next?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            guard slow !== fast else { break }
        }

        slow = head
        while slow !== fast {
            slow = slow?.next
            fast = fast?.next
        }

        return slow
    }
}




