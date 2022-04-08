
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

// MARK: - Two Sum 1

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()
    for index in 0..<nums.count {
        if let found = dict[target - nums[index]] {
            return [found, index]
        } else {
            dict[nums[index]] = index
        }
    }
    return []
    }

func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int:Int]()
        for (i, n) in nums.enumerated() {
            if let last = dict[target - n] {
                return [last, i]
            }
            dict[n] = i
        }
        return []
    }

func twoSum3(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int:Int]()
    
    for (i,num) in nums.enumerated() {
        if let index = dict[target - num] { // 0
            return [i, index].sorted()
        }
        dict[num] = i // [2:0,]
    }
    return []
}


// MARK: - Remove Duplicates from Sorted Array 26

func removeDuplicates(nums: inout [Int]) -> Int {
        guard nums.count != 0 && nums.count != 1 else { return nums.count }
        var i = 0
        for j in 0..<nums.count { // 0, 1, 2, 3, 4, 5, 6, 7
          if nums[i] != nums[j] { // 0 != 1, 2 != 1, 3 !=
            i += 1 // 1, 2, 3
            nums[i] = nums[j] // [0,1,2,3]
          }
        }
        return i+1
    }

func removeDuplicates2(nums: inout [Int]) -> Int {
    var l = 0
    
    for r in 0..<nums.count {
        if nums[r] != nums[l] {
            l += 1
            nums[l] = nums[r]
        }
    }
    return l + 1
}

// MARK: - Squares of a sorted array 977

func sortedSquares(_ nums: [Int]) -> [Int] {
    
    var squared = [Int]()
    
    for num in 0..<nums.count {
        squared.append(nums[num] * nums[num])
    }
    
    squared.sort()
    
    return squared
    }

// MARK: - 3Sum 15

func threeSum(_ nums: [Int]) -> [[Int]] {
        // [-1,0,1,2,-1,-4]
        var result: [[Int]] = []
        let nums = nums.sorted() // [-4,-1,-1,0,1,2]
        let len = nums.count //6
        
        guard len >= 3 else { return result }
        
        for i in 0..<len { // 0, 1
            if i > 0 && nums[i] == nums[i-1] { continue }
            
            let num = 0 - nums[i] // 4, 1
            var a = i + 1 // 1, 2
            var b = len - 1 // 5, 5
            
            while a < b { // 2<5
                let numA = nums[a] // -1
                let numB = nums[b] // 2
                let sum = numA + numB // 1
                if sum == num { // true
                    result.append([nums[i], numA, numB]) // [-1,-1,2]
                    a += 1 // 3
                    while a < b && nums[a] == nums[a-1] { a += 1 }
                } else {
                    sum > num ? b -= 1 : (a += 1) // 2, 3, 4, 5
                }
            }
        }
        return result
    }


class Tests: XCTestCase {
    
    func test15() {
        let value = threeSum([-1,0,1,2,-1,-4])
        XCTAssertEqual([[-1,-1,2],[-1,0,1]], value)
    }
    
    func test15_2() {
        let value = threeSum([])
        XCTAssertEqual([], value)
    }
    
    func test15_3() {
        let value = threeSum([0])
        XCTAssertEqual(value, [])
    }
    
    func test977() {
        let intArray = [-4,-1,0,3,10]
        let value = sortedSquares(intArray)
        XCTAssertEqual(value, [0,1,9,16,100])
    }
    
    
    func test26() {
        var intArray = [1,1,2]
        let value = removeDuplicates2(nums: &intArray)
        XCTAssertEqual(value, 2)
    }
    
    func test26_1() {
        var intArray = [0,0,1,1,1,2,2,3,3,4]
        let value = removeDuplicates2(nums: &intArray)
        XCTAssertEqual(value, 5)
    }

    func test1() {
        let value = twoSum3([2,7,11,15], 9)
        XCTAssertEqual(value, [0,1])
    }
    
    func test1_2() {
        let value = twoSum3([3,2,4], 6)
        XCTAssertEqual(value, [1,2])
    }
    
    func test1_3() {
        let value = twoSum3([3,3], 6)
        XCTAssertEqual(value, [0,1])
    }
    
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
