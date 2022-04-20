
import Foundation

// MARK: - 704. Binary Search

func search(_ nums: [Int], _ target: Int) -> Int {
    for i in 0..<nums.count {
        if nums[i] == target {
            return i
        }
    }
    return -1
}

search([-1,0,3,5,9,12], 9)

func search2(_ nums: [Int], _ target: Int) -> Int {
   
    var left = 0, right = nums.count - 1
    
    while left <= right {
        let middle = (left + right) / 2
        if nums[middle] < target {
            left = middle + 1
        } else if nums[middle] > target {
            right = middle - 1
        } else {
            return middle
        }
    }
    return -1
}

search2([-1,0,3,5,9,12], 9)
