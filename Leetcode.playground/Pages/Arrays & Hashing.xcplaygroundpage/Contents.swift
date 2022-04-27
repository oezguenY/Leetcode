
import Foundation

// MARK: - Valid Anagram 242

func isAnagram(_ s: String, _ t: String) -> Bool {
    
    let sSorted = s.sorted()
    let tSorted = t.sorted()
    
    if sSorted == tSorted {
        return true
    }
    return false
    
}


var string1 = "car"
var string2 = "rac"

isAnagram(string1, string2)

func isAnagram2(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }
    var hash = [Character:Int]()
    
    for char in s {
        hash[char, default: 0] += 1
    }
    
    for char in t {
        if let contains = hash[char] {
            if contains == 1 {
                hash[char] = nil
            } else {
                hash[char,default: 0] -= 1
            }
        }
    }
    if hash.isEmpty {
        return true
    }
    return false
    
}

isAnagram2("car", "rac")


func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int:Int]()
    
    for (i,num) in nums.enumerated() {
        if let index = dict[target - num] { // 0
            return [index, i]
        }
        dict[num] = i // [2:0,]
    }
    return []
}
twoSum([3,2,4], 6)

// MARK: - Group Anagrams 49

func groupAnagrams(_ strs: [String]) -> [[String]] {
    var dict = [[Character]:[String]]()
    
    for c in strs {
        let abc = c.sorted()
        dict[abc] == nil ? dict[abc] = [c] : dict[abc]?.append(c)
    }
    return dict.map({$1})
}


groupAnagrams(["eat","tea","tan","ate","nat","bat"])

// MARK: - Top K Frequent Elements 347

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    
    var hash = [Int:Int]()
    var result = [Int]()
    
    for num in nums {
        if let _ = hash[num] {
            hash[num,default: 0] += 1
        } else {
            hash[num] = 1
        }
    }
    
    let highest = hash.sorted { $0.value > $1.value }.prefix(k)
    
    for high in highest {
        result.append(high.key)
    }
    
    return result
}

topKFrequent([1,1,1,2,2,3], 2)

// MARK: - Product of array except self 238

func productExceptSelf(_ nums: [Int]) -> [Int] {
    var left = [Int]()
    var right = [Int]()
    var curSumLeft = 1
    var curSumRight = 1
    
    for i in 0..<nums.count {
        if i == 0 {
            left.append(1)
        } else {
            curSumLeft *= nums[i-1]
            left.append(curSumLeft)
        }
    }
    
    for j in (0..<nums.count).reversed() {
        if j == nums.count - 1 {
            right.append(1)
        } else {
            curSumRight *= nums[j+1]
            right.append(curSumRight)
        }
    }
    
    right.reverse()
    
    let result = zip(left, right).map({ $0 * $1 })
    
    return result
}

productExceptSelf([1,2,3,4])

// MARK: - 128. Longest Consecutive Sequence

func longestConsecutive(_ nums: [Int]) -> Int {
    guard nums.count > 1 else { return nums.count }
    let sorted = Set(nums).sorted()
    var longest = 0
    var longestSums = [Int]()
    for i in 1..<sorted.count {
        if sorted[i] - 1 == sorted[i - 1] {
            longest += 1
        } else {
            longestSums.append(longest)
            longest = 0
        }
    }
    longestSums.append(longest)
    var longestAdded = longestSums.max() ?? 0
    longestAdded += 1
    
    return longestAdded
}


longestConsecutive([0,3,7,2,5,8,4,6,0,1])

// MARK: - Valid palindrome 125

func isPalindrome(_ s: String) -> Bool {
    
    let chars = s.lowercased().filter { $0.isLetter || $0.isNumber }
    if String(chars.reversed()) == chars {
        return true
    }
    return false
}

isPalindrome(" ")

// MARK: - Container with most water 11

func maxArea(_ height: [Int]) -> Int {
    
    
    var j = height.count - 1, i = 0
    var maxArea = Int.min
    
    while i <= j { // j = 8
        let area = (j - i) * min(height[j], height[i])
        maxArea = max(area, maxArea)
        if height[i] > height[j] {
            j -= 1
        } else {
            i += 1
        }
    }
    return maxArea
    
}

maxArea([1,8,6,2,5,4,8,3,7])

// MARK: - 287. Find the Duplicate Number

func findDuplicate(_ nums: [Int]) -> Int {
    
    var hash: [Int:Int] = [:]
    
    for i in 0..<nums.count { // 0, 1, 2, 3, 4
        if let _ = hash[nums[i]] { //
            return nums[i]
        } else {
            hash[nums[i],default: 0] += 1 // [1:1,3:1,4:1,2:1]
        }
    }
    return -1
}

findDuplicate([1,3,4,2,2])


// MARK: - 1512. Number of Good Pairs
// Brute Force
func numIdenticalPairs(_ nums: [Int]) -> Int {
    var count = 0
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] == nums[j] {
                count += 1
            }
        }
    }
    return count
}

// Efficient

func numIdenticalPairs2(_ nums: [Int]) -> Int {
    var res = 0, map = [Int:Int]()
    nums.forEach { // 1, 2, 3, 1, 1, 3 // 1, 1, 1, 1
        res += map[$0] ?? 0 // 1, 3, 4 // 1, 3, 6
        map[$0,default: 0] += 1 // [1:2,2:1,3:2] // [1:3]
    }
    return res
}

func numIdenticalPairs3(_ nums: [Int]) -> Int {
    var count = 0, hash = [Int:Int]()
    
    nums.forEach {
        count += hash[$0] ?? 0
        hash[$0,default: 0] += 1
    }
    return count
}

numIdenticalPairs3([1,2,3,1,1,3])
numIdenticalPairs([1,1,1,1])

// MARK: - 771. Jewels and Stones

func numJewelsInStones(_ jewels: String, _ stones: String) -> Int {
    var count = 0
    
    stones.forEach {
        if jewels.contains($0) {
            count += 1
        }
    }
    return count
}

numJewelsInStones("aA", "aAAbbbb")
numJewelsInStones("z", "ZZ")

// MARK: - 1365. How Many Numbers Are Smaller Than the Current Number

func smallerNumbersThanCurrent(_ nums: [Int]) -> [Int] {
    let sortedNums = nums.sorted() // [1,2,2,3,8]
    var dict = [Int:Int]()
    
    for (index, n) in sortedNums.enumerated() {
        if dict[n] == nil {
            // the values correspond to the number of integer the key is bigger than
            dict[n] = index // [1:0,2:1,3:3,8:4]
        }
    }
    
    // then we transform every value in the array to the corresponding dictinary value for the key
    return nums.map { dict[$0]! }
}

smallerNumbersThanCurrent([8,1,2,2,3])


func smallerNumbersThanCurrent2(_ nums: [Int]) -> [Int] {
    let sortedNums = nums.sorted()
    var hash = [Int:Int]()
    
    for (index,num) in sortedNums.enumerated() {
        if hash[num] == nil {
            hash[num] = index
        }
    }
    return nums.map( {hash[$0]!} )
}

smallerNumbersThanCurrent2([1,1,1,1,1,2,2,3,5,6,8])
