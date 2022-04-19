
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

