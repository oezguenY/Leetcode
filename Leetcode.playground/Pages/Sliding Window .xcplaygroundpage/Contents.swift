
import Foundation
import XCTest

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
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
        currentMax = max(array[i], currentMax + array[i]) // 3, 5, 4
        globalMax = max(currentMax, globalMax) // 3, 5, 5
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
    for windowEnd in 0..<nums.count{ // 0, 1, 2
        sum += nums[windowEnd] // 3, 5, 6
        
        while(sum >= target) {
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

func minSubarrayLen2(nums: [Int], target: Int) -> Int {
    
    var currentSum = 0, minLength = Int.max, l = 0
    
    for r in 0..<nums.count {
        currentSum += nums[r]
        
        while currentSum >= target {
            minLength = min(minLength, r - l + 1)
            currentSum -= nums[l]
            l += 1
        }
    }
    if minLength == Int.max {
        return 0
    }
    return minLength
}




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

func lengthOfLongestSubstring2(_ s: String) -> Int {
        guard s.count > 1 else { return s.count }
        let arr = Array(s) // converting the input string into an array
        var seen = [Character: Int]()
        var left = 0
        var right = 0
        var longest = 0
        while right < arr.count { // 0,1,2,3,4
            let current = arr[right] // A,B,C,A,B
            // Here we are accessing the values. If the key is in the dict and its equal to or greater than left...
            if let found = seen[current], found >= left { // skipped
                // we add one to found and assign it to left
                left = found + 1 // 1,2
            }
            seen[current] = right // [C:2], [A:3], [B:4]
            longest = max(longest, right - left + 1) // 1, 2, 3, 3, 3
            right += 1 // 1, 2, 3, 4, 5
        }
        return longest
    }

lengthOfLongestSubstring2("abcab")

// MARK: Longest Repeating Character Replacement - Leetcode 424


func characterReplacement(s: String, k: Int) -> Int {
    let sarray = Array(s)
    var dict: [Character: Int] = [:]
    var result = 0
    var l = 0
    
    for r in 0..<sarray.count {
        let char = sarray[r]
        if dict[char] != nil {
            dict[char]! += 1
        } else {
            dict[char] = 1
        }
        // if we exceed the number of replacements we are allowed to make..
        if (r - l + 1) - dict.values.max()! > k {
            let lchar = sarray[l]
            if dict[lchar] != nil {
                dict[lchar]! -= 1
            }
            l += 1
        }
        result = max(result, r - l + 1)
    }
    
    return result
}
characterReplacement(s: "ABABBA", k: 2)


// MARK: - Max Consecutive Ones - Leetcode 485

func maxConsecutiveOnes(nums: [Int]) -> Int {
    var currentMax = 0
    var maxOnes = 0
    
    for num in 0..<nums.count {
        if nums[num] == 1 {
            currentMax += 1
            maxOnes = max(maxOnes, currentMax)
        } else {
            currentMax = 0
        }
    }
    return maxOnes
}

maxConsecutiveOnes(nums: [1,1,0,1,1,1])

// MARK: - Max Consecutive Ones iii - Leetcode 1004

func maxConsecutiveOnes3(_ nums: [Int], _ k: Int) -> Int {
    var k = k
    var i = 0
    var j = 0
    
    while i < nums.count { // 0, 1, 2, 3, 4, 5
        if nums[i] == 0 {
            k -= 1 // 1, 0, -1, -1
        }
        if k < 0 {
            if nums[j] == 0 {
                k += 1 // 0, 0
            }
            // we only move j if k < 0, which means that there are more 0 than we can flip
            j += 1 // 1, 2
        }
        i += 1 // 1, 2, 3, 4, 5
    }
    return i-j
}

maxConsecutiveOnes3([0,0,0,0,1], 2)

// MARK: - Permutation in String - Leetcode 567

// Time complexity: O(lengthOf(s2))
// Space complexity: O(lengthOf(s2))
func checkInclusion(_ s1: String, _ s2: String) -> Bool {
    // Initial sanity checks
    guard !s1.isEmpty, !s2.isEmpty, s1.count <= s2.count else { return false }
    
    // Compose a dictuionary with characters form string 1
    var map1: [Character: Int] = [:]
    let chars1 = Array(s1)
    for char in chars1 {
        map1[char] = map1[char, default: 0] + 1 // ["b": 1, "a": 2]
    }
    
    
    // Sliding window preparation: dictionary of characters from string 2 from 0 positon to position of string 1 length
    let chars2 = Array(s2)
    var map2: [Character: Int] = [:]
    for i in 0..<chars1.count {
        map2[chars2[i]] = map2[chars2[i], default: 0] + 1 // [k:1,b:1,a:1]
    }
    
    
    // Then go through string 2 comparing window to map1 and modifying it if it doesn't match
    // Modification throws away left character and adds new from the right
    for i in chars1.count..<chars2.count {
        guard map1 != map2 else { return true }
        // getting the leftmost character frequency of map2 (which is 1 for k the first iteration)
        if let value = map2[chars2[i - chars1.count]] {
            map2[chars2[i - chars1.count]] = value > 1 ? value - 1 : nil // [b:1,a:1]
        }
        map2[chars2[i]] = map2[chars2[i], default: 0] + 1 // [b:1,a:2]
    }
    
    // If we went through string 2 and map2 has never been equal to map1 there is no permutation of string 1 in string 2
    return map1 == map2
}

checkInclusion("aba", "kbaaj")

// MARK: - Find Anagrams

func findAnagrams(_ s: String, _ p: String) -> [Int] {
      
      var dictP = [Character: Int]()
      var dictS = [Character: Int]()
      var result: [Int] = []
      let s = Array(s)
      let pCount = p.count // 3
      
      for char in p {
          dictP[char, default: 0] += 1 // [a:1,b:1,c:1]
      }
      // s.count = 4
      for i in 0..<s.count { // 0, 1, 2, 3
          
          //Remove first char in the dictionary
          if i >= pCount {
              let char = s[i - pCount] // o
              dictS[char] = dictS[char]! > 1 ? dictS[char]! - 1 : nil // remove o
          }
          
          //Find a window of pCount letters to compare
          dictS[s[i], default: 0] += 1 // [b:1,c:1,a:1]
          
          if dictS == dictP {
              result.append(i - pCount + 1)
          }
      }
      
      return result
  }

findAnagrams("obca", "abc")

// MARK: - Minimum Window Substring (Hard) - Leetcode 76

func minWindow(_ s: String, _ t: String) -> String {
    
    let tArray = Array(t)
    let sArray = Array(s)
    var sHash = [Character:Int]()
    var thash = [Character:Int]()
    var i = 0
    var j = 0
    var found = 0
    var result = ""
    
    for char in tArray {
        thash[char, default: 0] += 1 // [A:2]
    }
    
    while j < sArray.count { // 0, 1, 2, 3, 4, 5 // 0
        sHash[sArray[j],default: 0] += 1 // [A:2,B:2:C:1] // [A:1]
        if let count = thash[sArray[j]], count > 1 {
            found += 1 // 1, 2, 3
            if found == tArray.count {
                let start = s.index(s.startIndex, offsetBy: i) // 0
                let end = s.index(s.endIndex, offsetBy: -1 * (s.count - j)) // -1
                let range = start...end
                let currentResult = s[range]
                if result.isEmpty {
                    result = String(currentResult) // "AAABBC"
                } else {
                    if currentResult.count < result.count {
                        result = String(currentResult)
                    }
                }
                while found == thash.count {
                    i += 1 // 1, 2, 3
                    let char2 = sArray[i - 1] // A, A, A
                    sHash[char2,default: 0] -= 1 // [A:0,B:2:C:1]
                    if let count = thash[char2], count != sHash[char2] { // 1 != 2
                        found -= 1 // 2
                        let start = s.index(s.startIndex, offsetBy: i - 1) // 2
                        let end = s.index(s.endIndex, offsetBy: -1 * (s.count - j)) // -1
                        let range = start...end
                        let currentResult = s[range] // "ABBC"
                        if result.isEmpty {
                            result = String(currentResult)
                        } else {
                            if currentResult.count < result.count {
                                result = String(currentResult)
                            }
                        }
                    }
                }
                }
            }
            j += 1 // 1, 2, 3, 4, 5
        }
        return result
    }

minWindow("aaa", "aa")
minWindow("aaabbcc", "abc")
minWindow("abbbbba", "bba")
minWindow("abc", "cba")
minWindow("ADOBECODEBANC", "ABC")



func minWindow2(_ s: String, _ t: String) -> String {
        
        guard s.count > 0, t.count > 0 else { return "" }
        
        var tDict: [Character: Int] = [:]
        for c in t {
            tDict[c, default: 0] += 1 // [A:2]
        }
        
        var left = 0, right = 0, formed = 0
        var savedLeft = 0
        var savedRight = 0
        var savedLength = -1
        
        var windowDict: [Character: Int] = [:]
        let s = Array(s) // ["A","A","A"]
        
        while right < s.count { // 0...3, 0, 1
            let c = s[right] // A, A
            windowDict[c, default: 0] += 1 // [A:2]
            
            if let count = tDict[c], count == windowDict[c] { // skipped,
                formed += 1 // 1
            }
            
            while left <= right, formed == tDict.count { // entered
                let c = s[left] // A
                if savedLength == -1 || right - left + 1 < savedLength { 
                    savedLength = right - left + 1
                    savedLeft = left
                    savedRight = right
                }
                
                if let count = windowDict[c], count > 0 {
                    windowDict[c] = count - 1
                    
                    if let required = tDict[c], count - 1 < required {
                        formed -= 1
                    }
                }
                left += 1
            } 
            right += 1 // 1
        }
        return savedLength == -1 ? "" : String(s[savedLeft...savedRight])
    }


// MARK: - Maximum Subarray - Leetcode 53

func maxSubArray2(_ nums: [Int]) -> Int {
   // do we continue the sequence or do we break it and start over?
    var sum = 0
    var answer = Int.min
    
    for num in nums {
        sum = max(num, num + sum) // -2, 1, -2, 4
        answer = max(sum, answer)
    }
    return answer
   }

func maxSubArray3(_ nums: [Int]) -> Int {
    var sum = 0
    var answer = Int.min
    
    for num in nums {
        sum = max(num, num + sum)// for every iteration, we either expand our sequence or we start over
        answer = max(answer, sum)
    }
    return answer
}

// MARK: - Fruit into baskets - Leetcode 904

func totalFruit(_ tree: [Int]) -> Int {
        var i = 0
        var dict: [Int:Int] = [:]
        var global = 0
        
        for j in 0..<tree.count { // 0, 1, 2, 3, 4
            if let duplicate = dict[tree[j]] { // nil, nil, nil
                dict[tree[j]] = duplicate + 1 // [2:3,3:1]
            } else {
                dict[tree[j]] = 1 // [1:1,2:1,3:1]
            }
            while dict.count >= 3 {
                if let duplicate = dict[tree[i]] { // 1
                    dict[tree[i]] = duplicate - 1 // 0
                }
                if dict[tree[i]] == 0 {
                    dict[tree[i]] = nil // [2:1,3:1]
                }
                i += 1 // 1
            }
            global = max(global, j - i + 1) // 1, 2, 2, 3, 4
        }
        return global
    }

func totalFruit2(_ nums: [Int]) -> Int {
    var i = 0
    var dict = [Int:Int]()
    var global = Int.min
    
    for j in 0..<nums.count {
        if let _ = dict[nums[j]] {
           dict[nums[j],default: 0] += 1
        } else {
            dict[nums[j]] = 1
        }
        while dict.count >= 3 {
            if let _ = dict[nums[i]] {
                dict[nums[i],default: 0] -= 1
            }
            if dict[nums[i]] == 0 {
                dict[nums[i]] = nil
            }
            i += 1
        }
        global = max(global, j - i + 1)
    }
    return global
}

func lengthOfLongestSubstring3(_ s: String) -> Int {
        guard s.count > 0 else { return 0 }
        
        let sArr = Array(s) // pwwkew
        
        var lastIndexes: [Character: Int] = [:]
        
        var result = Int.min
        
        var windowStart = 0
        for windowEnd in 0..<sArr.count { // 0, 1, 2, 3, 4, 5
            let rightCharacter = sArr[windowEnd] // p, w, w, k, e, w

            // if we have seen a character before, remove characters up until seenIndex
            if let seenIndex = lastIndexes[rightCharacter] { // 1
                while windowStart <= seenIndex {
                    let leftCharacter = sArr[windowStart] // p
                    lastIndexes[leftCharacter] = nil // remove p
                    windowStart += 1 // 1
                }
            }
            
            // calculate current string length and compare it with max length
            lastIndexes[rightCharacter] = windowEnd // [k:3,e:4,w:5]
            result = max(result, windowEnd - windowStart + 1) // 1, 2, 1, 2, 3, 3
        }
        
        return result
    }

// MARK: - Longest Substring Without Repeating Characters - Leetcode 3

func lengthOfLongestSubstring4(_ s: String) -> Int {
    guard s.count >= 1 else { return 0 }
    
    var i = 0, longest = Int.min, arr = Array(s), dict = [Character:Int]()
    
    for j in 0..<arr.count { // 0, 1, 2, 3, 4, 5
        if let foundAtIndex = dict[arr[j]] { // 1, 2
            while i <= foundAtIndex {
                dict[arr[i]] = nil // [k:3,e:4]
                i += 1  // 1, 2, 3
            }
        }
        dict[arr[j]] = j // [k:3,e:4,w:5]
        longest = max(longest, j - i + 1) // 1, 2, 1, 2, 3, 3
    }
    return longest
}

// "pwwkew"

// MARK: - Minimum Size Subarray Sum - Leetcode 209

class Tests: XCTestCase {
    
    func test3_0() {
        let value = lengthOfLongestSubstring4("abcabcbb")
        XCTAssertEqual(value, 3)
    }
    
    func test3_1() {
        let value = lengthOfLongestSubstring4("bbbbb")
        XCTAssertEqual(value, 1)
    }
    
    func test3_2() {
        let value = lengthOfLongestSubstring4("pwwkew")
        XCTAssertEqual(value, 3)
    }
    
    func test904_0() {
        let value = totalFruit2([1,2,1])
        XCTAssertEqual(value, 3)
    }
    
    func test904_1() {
        let value = totalFruit2([0,1,2,2])
        XCTAssertEqual(value, 3)
    }
    
    func test904_2() {
        let value = totalFruit2([1,2,3,2,2])
        XCTAssertEqual(value, 4)
    }
    
    func test53_0() {
        let value = maxSubArray3([-2,1,-3,4,-1,2,1,-5,4])
       XCTAssertEqual(value, 6)
    }
    
    func test53_1() {
        let value = maxSubArray3([1])
        XCTAssertEqual(value, 1)
    }
    
    func test53_2() {
        let value = maxSubArray3([5,4,-1,7,8])
        XCTAssertEqual(value, 23)
    }
    
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
    
    func test209_0() {
        let value = minSubarrayLen2(nums: [2,3,1,2,4,3], target: 7)
        XCTAssertEqual(value, 2)
    }
    
    func test209_1() {
        let value = minSubarrayLen2(nums: [1,4,4], target: 4)
        XCTAssertEqual(value, 1)
    }
    
    func test209_2() {
        let value = minSubarrayLen2(nums: [1,1,1,1,1,1,1,1], target: 11)
        XCTAssertEqual(value, 0)
    }
    
}

Tests.defaultTestSuite.run()


