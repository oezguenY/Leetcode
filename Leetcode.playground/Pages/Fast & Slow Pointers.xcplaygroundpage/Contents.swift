
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
