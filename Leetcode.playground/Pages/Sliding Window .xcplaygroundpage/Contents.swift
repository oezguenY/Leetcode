
import Foundation
import XCTest

// MARK: - Maximum Subarray

/*
 Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.
 
 A subarray is a contiguous part of an array.
 
 
 
 Example 1:
 
 Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
 Output: 6
 Explanation: [4,-1,2,1] has the largest sum = 6.
 Example 2:
 
 Input: nums = [1]
 Output: 1
 Example 3:
 
 Input: nums = [5,4,-1,7,8]
 Output: 23
 
 
 Constraints:
 
 1 <= nums.length <= 105
 -104 <= nums[i] <= 104
 
 
 Follow up: If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.
 */

// MARK: - Kadane's Algorithm

func maxSubArray(_ nums: [Int]) -> Int {
    var curSum = nums[0] // -1
    var maxSum = nums[0] // -1
    // every time we iterate, we are asking ourselves "What's the maximum/minimum subarray ending at this index? Is it just the value at the index or is it the currentMax + the current value?"
    for i in 1..<nums.count { // 1 // 2 // 3
        curSum = max(nums[i], curSum + nums[i]) // 2 // 5 // 2
        maxSum = max(maxSum, curSum) // 2 // 5 // 5
    }
    return maxSum
}

maxSubArray([-1,2,3,-3])
// cs is asking, is the iterated value bigger or the iterated value plus the first value?
// ms is asking, is the first value bigger or cs?

// given this array, which sequence of values can theoretically be largest?
// first, first + second, second, second + third, third, first + second + third

maxSubArray([1,2,3])

/*
 Pseudocode:
 
 - create two variables
 - in one variable, you store the current sum
 - in the other, you store the global sum
 - both start at index 0 of the fed in array
 - loop through the elements of the array,
 
 */

func maxSubArrayTry(array: [Int]) -> Int {
    var currentMax = array[0]
    var globalMax = array[0]
    
    for i in 1..<array.count {
        currentMax = max(array[i], currentMax + array[i])
        globalMax = max(currentMax, globalMax)
    }
    return globalMax
}

maxSubArrayTry(array: [-2,3,2,-1])
maxSubArray([-2,3,2,-1])


// MARK: - Minimum Size Subarray Sum

/*
 Given an array of positive integers nums and a positive integer target, return the minimal length of a contiguous subarray [numsl, numsl+1, ..., numsr-1, numsr] of which the sum is greater than or equal to target. If there is no such subarray, return 0 instead.
 
 
 
 Example 1:
 
 Input: target = 7, nums = [2,3,1,2,4,3]
 Output: 2
 Explanation: The subarray [4,3] has the minimal length under the problem constraint.
 Example 2:
 
 Input: target = 4, nums = [1,4,4]
 Output: 1
 Example 3:
 
 Input: target = 11, nums = [1,1,1,1,1,1,1,1]
 Output: 0
 
 
 Constraints:
 
 1 <= target <= 109
 1 <= nums.length <= 105
 1 <= nums[i] <= 105
 
 
 Follow up: If you have figured out the O(n) solution, try coding another solution of which the time complexity is O(n log(n)).
 */

// Sliding Window

func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
    var minLength = Int.max, windowStart = 0, sum = 0
    for windowEnd in 0..<nums.count{ // 2
        sum += nums[windowEnd] // 3 // 5 // 6
        
        while(sum >= target){
            minLength = min(minLength, windowEnd - windowStart + 1) // 3
            sum -= nums[windowStart] // 3
            windowStart += 1 // 1
        }
    }
    if minLength == Int.max{
        return 0
    }
    return minLength
}

minSubArrayLen(6, [3,2,1,5,2])
minSubArrayLen(7, [2,3,1,2,4,3])



// MARK: - Find the smallest subarray with given sum

func smallestSubarray(array: [Int], target: Int) -> Int? {
    var minValue = Int.max
    var currentSum = 0
    var windowStart = 0
    
    for windowEnd in 0..<array.count {
        currentSum += array[windowEnd]
        
        while currentSum >= target {
            minValue = min(minValue, windowEnd - windowStart + 1)
            currentSum -= array[windowStart]
            windowStart += 1
        }
    }
    if minValue == Int.max{
        return 0
    }
    return minValue
}

smallestSubarray(array: [4,2,2,7,8,1,2,8,10], target: 15)


// MARK: - Find the maximum sum subarray of a fixed size K


func findMaxSubArray(array: [Int], size: Int) -> Int? {
    var maxValue = Int.min
    var currentSum = 0
    
    for i in 0..<array.count {
        currentSum += array[i]
        
        if i >= size - 1 {
            maxValue = max(maxValue, currentSum)
            currentSum -= array[i - (size - 1)]
        }
    }
    return maxValue
}

findMaxSubArray(array: [3,5,8,1,5,2,6,9], size: 3)


// MARK: - Maximum consecutive ones (if k flip is allowed)

// Given an array which only consists of 0s and 1s, write code to find the maximum number of consecutive 1s in an array if we can flip zeros

func countConsecutiveOnes(array: [Int], k: Int) -> Int {
    
    var maxConsecutiveOnes = Int.min
    var start = 0
    var zeroCount = 0
    
    for end in 0..<array.count { // 0
        if array[end] == 0 { // skipped
            zeroCount += 1
        }
        
        while zeroCount > k { // skipped
            if array[start] == 0 {
                zeroCount -= 1
            }
            start += 1
        }
        maxConsecutiveOnes = max(maxConsecutiveOnes, end-start+1) // 1
    }
    
    if maxConsecutiveOnes == Int.min { // skipped
        return 0
    }
    
    return maxConsecutiveOnes
}

countConsecutiveOnes(array: [0,0,0,0,0,0], k: 2)


// MARK: -  Longest Substring Without Repeating Characters

/*
 Given a string s, find the length of the longest substring without repeating characters.
 
 Example 1:
 
 Input: s = "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.
 Example 2:
 
 Input: s = "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.
 Example 3:
 
 Input: s = "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
 Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */

func lengthOfLongestSubstring(_ s: String) -> Int {
    let str = Array(s), n = str.count
    var index = [Character: Int](), left = 0, ans = 0
    for right in 0..<n {
        left = max(left, index[str[right], default: -1] + 1)
        index[str[right]] = right
        ans = max(ans, right - left + 1)
    }
    return ans
}

class Tests: XCTestCase {
    
    // The answer is "abc", with the length of 3.
    func test0() {
        let value = lengthOfLongestSubstring("abcabcbb")
        XCTAssertEqual(value, 3)
    }
    
    // The answer is "b", with the length of 1.
    func test1() {
        let value = lengthOfLongestSubstring("bbbbb")
        XCTAssertEqual(value, 1)
    }
    
    // The answer is "wke", with the length of 3.
    // Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
    func test2() {
        let value = lengthOfLongestSubstring("pwwkew")
        XCTAssertEqual(value, 3)
    }
}

Tests.defaultTestSuite.run()
