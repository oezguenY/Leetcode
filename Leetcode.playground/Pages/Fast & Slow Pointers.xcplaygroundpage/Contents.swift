
import Foundation
import XCTest

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

// MARK: - Happy Number 202

func isHappy(_ n: Int) -> Bool {
    var slow = n
    var fast = n
    
    while true {
        slow = getNext(slow)
        fast = getNext(fast)
        fast = getNext(fast)
        
        if slow == fast {
            break
        }
    }
    
    return fast == 1
}

func isHappy2(_ n: Int) -> Bool {
        var input = n
        var seen = Set<Int>()
        
        while input != 1 {
            if seen.contains(input) {
                return false
            }
            
            seen.insert(input)
            input = getNext(input)
        }
        
        return true
    }

private func getNext(_ n: Int) -> Int {
    var sum = 0
    var input = n
    
    while input > 0 {
        let remainder = input % 10
        sum += remainder * remainder
        input /= 10
    }
    
    return sum
}

class Tests: XCTestCase {
    
    func test202() {
        let value = isHappy(19)
        XCTAssertEqual(value, true)
    }
    
    func test202_2() {
        let value = isHappy(2)
        XCTAssertEqual(value, false)
    }
}

Tests.defaultTestSuite.run()
