
import Foundation
import XCTest

// MARK: - Merge Intervals 56

func merge(_ intervals: [[Int]]) -> [[Int]] {
        // [[1,3],[2,6],[8,10],[15,18]]
        // sort by the first integer
        let sorted = intervals.sorted(by: {$0[0] < $1[0]})
        guard let first = sorted.first else { return [[Int]]() }

        var merged = [first]
        
        for current in sorted {
            guard let last = merged.last else { continue }

            let prev = last[0]
            let penult = last[1]
            
            let start = current[0], end = current[1]
            
            if penult >= start {
                merged[merged.count - 1] = [prev, max(penult, end)]
            } else {
                merged.append(current)
            }
        }
        return merged
    }

merge([[1,3],[2,6],[8,10],[15,18]])

class Tests: XCTestCase {
    
    func test56() {
        let value = merge([[1,3],[2,6],[8,10],[15,18]])
        XCTAssertEqual(value, [[1,6],[8,10],[15,18]])
    }
    
    func test56_2() {
        let value = merge([[1,4],[4,5]])
        XCTAssertEqual(value, [[1,5]])
    }
    
    
}
Tests.defaultTestSuite.run()
