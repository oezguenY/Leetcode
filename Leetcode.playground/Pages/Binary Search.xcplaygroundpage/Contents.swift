
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

// MARK: - 74. Search a 2D Matrix

func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    
    let oneD = matrix.flatMap { $0 }
    var left = 0, right = oneD.count - 1
    
    while left <= right {
        let middle = (left + right) / 2
        if oneD[middle] < target {
            left = middle + 1
        } else if oneD[middle] > target {
            right = middle - 1
        } else {
            return true
        }
    }
    return false
}


searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3)

// MARK: - 875. Koko Eating Bananas

/*
 Question: How many bananas has koko to eat minimum in an hour so she can eat all the piles?
 Pseudocode:
 - 1) the minimum answer has to be 1. Because if its below one, koko eats no bananas per hour
 - 2) Koko cant eat more than 1 pile of bananas per hour
 - the conclusion from 2) is that the maximum number of bananas koko can eat per hour is the maximum pile. Even if she could eat 100x the amount of bananas per hour, she can only finish one pile of bananas per hour.
 - the logical conclusion from 1) and 2) are that koko can eat 1...max(piles)
 - this range contains the different quantities of bananas koko can eat in one hour, so she finishes all the piles in the set amount of hours
 - we are looking for the MINIMUM amount of bananas koko can eat in an hour, so she finishes all the piles in the set time
 - our range is sorted (lowest to highest)
 - say we picked the middle value from our range. Say the value (for the amount of bananas eaten in an hour) we picked is so high, that koko finishes way faster than the set number of hours. This value is a false answer, because we want the MINIMUM number of bananas eaten by koko in an hour so she finishes in the set amount of time.
 */

// THIS SOLUTION IS UNOPTIMIZED

func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
    guard piles.count > 0 else { return -1 }
    let range = Array(1...piles.max()!)
    var l = 0, r = range.count - 1
    
    while l <= r {
        let m = (l + r) / 2 // 5, 2, 3
        let hours = piles.map( { Double(ceil(Double($0) / Double(range[m])))} ).reduce(0,+) // gives us the amount of hours koko needs to eat all piles given a specific speed (amount of bananas she eats in an hour) // range[m] = 6 // [1,1,2,2]
        // range[m] = 3 // [1,2,3,4]
        // range[m] = 4 // [1,2,2,3]
        if Int(hours) < h { // 6 < 8
            r = m - 1 // 4
        } else if Int(hours) > h { // 10 > 8
            l = m + 1 // 3
        } else {
            return range[m]
        }
    }
    return -1
}

minEatingSpeed([3,6,7,11], 8)

// THIS IS OPTIMIZED

func minEatingSpeed2(_ piles: [Int], _ h: Int) -> Int {
    
    var l = 1, r = piles.max()!// r = 11
    var result = r
    while l <= r { // 1 <= 11
        let m = (l + r) / 2 // 6, 3, 4
        let hours = piles.map( { Double(ceil(Double($0) / Double(m)))} ).reduce(0,+)
        if Int(hours) <= h { // 6 < 8 // 8 == 8
            result = min(result, m) // 6 // 8
            r = m - 1 // 5
        } else { // 10 > 8
            l = m + 1 // 4
        }
    }
    return result
}


minEatingSpeed2([3,6,7,11], 8)

// MARK: - 33. Search in Rotated Sorted Array

func searchRotated(_ nums: [Int], _ target: Int) -> Int {
    
    
    // [4,5,6,7,0,1,2]
    // [0,1,2,4,5,6,7]
    // [6,7,0,1,2,4,5]
    // [2,4,5,6,7,0,1] // 0
    // [7,0,1,2,4,5,6] // 0
    //  l     m     r
    
    // if left is equal/smaller than middle -> if target is greater than middle or target is smaller than left ITS ON THE RIGHT else ITS ON THE LEFT
    // else if left is not equal/smaller than middle -> if target is smaller than middle or target is greater than right ITS ON THE LEFT else ITS ON THE RIGHT
    
    var l = 0, r = nums.count - 1
    
    while l <= r {
        let m = (l + r) / 2
        if target == nums[m] {
            return m
        }
        if nums[l] <= nums[m] {
            if target > nums[m] || target < nums[l]  {
                l = m + 1
            } else {
                r = m - 1
            }
        } else {
            if target < nums[m] || target > nums[r] {
                r = m - 1
            } else {
                l = m + 1
            }
        }
    }
    return -1
}

searchRotated([7,0,1,2,4,5,6], 0)


func searchRotated2( _ nums: [Int], _ target: Int) -> Int {
    
    // if left is less than mid, the left half is sorted
    // then i can ask whether the target value is <= to left and <= mid (so between the left and mid)
    // if its not there we shift the left pointer to mid + 1
    // if left is greater than mid, right half is sorted
    
    var l = 0, r = nums.count - 1
    
    while l <= r {
        let m = (l + r) / 2 // 3 // 1
        if nums[m] == target { return m } // if its found, return the index
        
        if nums[m] >= nums[l] {//if mid value is larger or equalthan left value, left part is sorted
            if nums[l] <= target && target <= nums[m] { // is our value in the sorted portion?
                r = m - 1 // if yes, exonerate the right half
            } else {
                l = m + 1 // if no, exonerate the left half
            }
        } else { // else if middle value is smaller than left, right part is sorted
            if nums[r] >= target && target >= nums[m] { // is our value in the sorted portion?
                l = m + 1 // if yes, exonerate left half
            } else {
                r = m - 1 // if no, exonerate right half // r = 2
            }
        }
    }
    return -1
}

searchRotated2([7,0,1,2,4,5,6], 0)
//                lm r

// MARK: - 153. Find Minimum in Rotated Sorted Array

func findMin(_ nums: [Int]) -> Int {
    
    var l = 0, r = nums.count - 1
    var lowest = nums[0]
    
    while l <= r {
        if nums[l] < nums[r] {
            lowest = min(lowest, nums[l])
        }
        let m = (l + r) / 2
        lowest = min(nums[m], lowest)
        if nums[l] <= nums[m] {
            l = m + 1
        } else {
            r = m - 1
        }
    }
    return lowest
}

findMin([4,5,6,7,0,1,2])
findMin([5,1,2,3,4])
findMin([4,5,1,2,3])
findMin([1])
findMin([3,1,2])
findMin([3,4,5,1,2])
findMin([11,13,15,17])


func findMin2(_ nums: [Int]) -> Int {
    
    var l = 0, r = nums.count - 1, lowest = nums[0]
    
    while l <= r {
        // only if the array is already sorted, l < r
        if nums[l] < nums[r] {
            lowest = min(lowest, nums[l])
            break
        }
        let m = (l + r) / 2
        // if the middle value is largeer/equal than the left value, we have to search the right side
        // the logic behind this is because we rotate the larger values to the front, so if the array
        // isnt sorted, the first portion of the array will always be larger than the second
        if nums[m] >= nums[l] {
            l = m + 1
            lowest = min(nums[m], lowest)
        } else {
            r = m - 1
            lowest = min(nums[m], lowest)
        }
    }
    return lowest
}


findMin2([4,5,6,7,0,1,2])
findMin2([5,1,2,3,4])
findMin2([4,5,1,2,3])
findMin2([1])
findMin2([3,1,2])
findMin2([3,4,5,1,2])
findMin2([11,13,15,17])
