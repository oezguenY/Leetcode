
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




