
import Foundation
import XCTest


// MARK: - 206. Reverse Linked List

class Node {
    var val: Int
    var next: Node?
    
    init() {
        self.val = 0
        self.next = nil
    }
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    init(_ val: Int, _ next: Node? = nil) {
        self.val = val
        self.next = next
    }
    
    func reverseList(_ head: Node?) -> Node? {
        guard head?.next != nil else { return head }
        var cur = head
        var prev: Node? = nil
        var next = cur?.next
        
        while next != nil {
            next = cur?.next
            cur?.next = prev
            prev = cur
            cur = next
        }
        return prev
    }
    

}

class ListNode {
    var val: Int
    var next: ListNode?
    init() {
        self.val = 0
        self.next = nil
    }
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    init(_ val: Int, _ next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
    
    // MARK: - 19. Remove Nth Node From End of List
    
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var slow = head, fast = head, counter = n
        
        for _ in 1...counter { // 1, 2
            fast = fast?.next // 2, 3
        }
        
        if fast == nil { return head?.next }

        while fast != nil {
            if fast?.next == nil {
                slow?.next = slow?.next?.next
            }
            slow = slow?.next
            fast = fast?.next
        }
        
        return head
    }
    
    // MARK: - 2. Add Two Numbers
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            var l1: ListNode? = l1
            var l2: ListNode? = l2
            
            var result: ListNode? = ListNode(0)
            let head = result
            
            var carry = 0
        // while either linked list has a digit
            while l1 != nil || l2 != nil || carry > 0 {
                let firstValue = l1?.val ?? 0 // 2, 4, 3
                let secondValue = l2?.val ?? 0 // 5, 6, 4
                // sum the digits
                let sum = firstValue + secondValue + carry // 7, 10, 8
                // if we have a sum of 15, value would be 5
                let value = sum % 10 // 7, 0, 8
                // sum of 15, carry would be 1
                carry = sum / 10 // 0, 1, 0
                
                result?.next = ListNode(value) // 0 -> 7 -> 0 -> 8
                result = result?.next // 7, 0, 8
                l1 = l1?.next // 4, 3, nil
                l2 = l2?.next // 6, 4, nil
            }
            
            return head?.next // 7
        }
    // l1 = [2,4,3], l2 = [5,6,4]
    
    
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
    
    // MARK: - Middle of the Linked List 876
    
    func middleNode(_ head: ListNode?) -> ListNode? {
        var (fast,slow) = (head, head)
        
        while(fast?.next != nil) {
            fast = fast?.next?.next
            slow = slow?.next
        }
        
        return slow
    }
    
    // MARK: - Palindrome Linked List
    // [1,2,2,1]
    func isPalindrome(_ head: ListNode?) -> Bool {
        var fast: ListNode? = head // 1
        var slow: ListNode? = head // 1
        
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next // nil
            slow = slow?.next // 2
        }
        // in case of odd numbers of nodes
        if fast != nil {
            slow = slow?.next
        }
        slow = reverse(slow) // 1
        fast = head // nil
        while slow != nil {
            if fast?.val != slow?.val {
                return false
            }
            fast = fast?.next
            slow = slow?.next
        }
        
        return true
    }
    // [1,2,2,1]
    private func reverse(_ head: ListNode?) -> ListNode? {
        var head = head // 2
        var pre: ListNode? = nil
        
        while head != nil {
            let next = head?.next // 1, nil
            head?.next = pre // 2 -> nil, 1 -> 2
            pre = head // 2, 1
            head = next // 1, nil
        }
        
        return pre
    }
    
    // MARK: - Reorder List 143
    
    func reorderList(_ head: ListNode?) {
        guard head != nil else { return }
        
        var slow = head
        var fast = head
        
        while fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        let reversedList = reverseList(slow)
        mergeLists(head, reversedList)
    }
    
    
    private func reverseList(_ head: ListNode?) -> ListNode? {
        var prev: ListNode? = nil
        var curr = head
        var next: ListNode? = nil
        
        while curr != nil {
            next = curr?.next
            
            curr?.next = prev
            prev = curr
            curr = next
        }
        
        return prev
    }
    
    
    private func mergeLists(_ first: ListNode?, _ second: ListNode?) {
        var first = first
        var second = second
        var tmp: ListNode? = nil
        
        while second?.next != nil {
            tmp = first?.next // next node
            first?.next = second
            first = tmp
            
            tmp = second?.next
            second?.next = first
            second = tmp
        }
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

// - Complexity:
//   - time: O(n log(n)), where n is the number of intervals.
//   - space: O(n), where n is the number of intervals.

func merge(_ intervals: [[Int]]) -> [[Int]] {
    guard !intervals.isEmpty else { return [] }
    // sorting by the start value
    let intervals = intervals.sorted(by: { $0[0] < $1[0] })
    
    var ans = [[Int]]()
    var start = intervals[0][0]
    var end = intervals[0][1]
    
    for interval in intervals {
        guard end < interval[0] else {
            end = max(end, interval[1])
            continue
        }
        ans.append([start, end])
        start = interval[0]
        end = interval[1]
    }
    
    ans.append([start, end])
    return ans
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
