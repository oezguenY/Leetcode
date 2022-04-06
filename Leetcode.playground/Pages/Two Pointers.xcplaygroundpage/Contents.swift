
import Foundation
import XCTest

// MARK: - Two Sum II - Input Array Is Sorted 167

func twoSumII(_ numbers: [Int], _ target: Int) -> [Int] {
    var left = 0, right = numbers.count - 1
    while left < right { // 0
        if numbers[left] + numbers[right] == target {
            return [left + 1, right + 1]
        } else if numbers[left] + numbers[right] < target {
            left += 1
        } else {
            right -= 1 // 2, 1
        }
    }

    return []
}

func twoSum2II(_ nums: [Int], _ target: Int) -> [Int] {
    var i = 0, j = nums.count - 1
    
    while i < j {
        if nums[i] + nums[j] == target {
            return [i + 1, j + 1]
        } else if nums[i] + nums[j] < target {
            i += 1
        } else {
            j -= 1
        }
    }
    return []
}

class Tests: XCTestCase {
    
    func test167() {
        let value = twoSum2II([2,7,11,15], 9)
        XCTAssertEqual(value, [1,2])
    }
    
    func test167_2() {
        let value = twoSum2II([2,3,4], 6)
        XCTAssertEqual(value, [1,3])
    }
    
    func test167_3() {
        let value = twoSum2II([-1,0], -1)
        XCTAssertEqual(value, [1,2])
    }
}

Tests.defaultTestSuite.run()
