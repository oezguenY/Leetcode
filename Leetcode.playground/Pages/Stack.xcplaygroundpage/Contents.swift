import Foundation

// MARK: - 150. Evaluate Reverse Polish Notation

func evalRPN(_ tokens: [String]) -> Int {
    
    var numStack = [Int]()
    
    for token in tokens {
        switch token {
        case "*":
            numStack.append((numStack.removeLast() * numStack.removeLast()))
        case "-":
            let a = numStack.removeLast()
            let b = numStack.removeLast()
            numStack.append((b - a))
        case "+":
            numStack.append((numStack.removeLast() + numStack.removeLast()))
        case "/":
            let a = numStack.removeLast()
            let b = numStack.removeLast()
            numStack.append(Int((b / a)))
        default:
            numStack.append(Int(token) ?? 0)
        }
    }
    
    return numStack[0]
}

evalRPN(["4","13","5","/","+"])

// MARK: - 22. Generate Parentheses

func generateParenthesis(_ n: Int) -> [String] {
    
    var stack = [String]()
    var result = [String]()
    
    func backtrack(openN: Int, closedN: Int) {
        if openN == closedN && openN == n {
            result.append(stack.joined(separator: "")) // ["(())"]
            print(result)
            return
        }
        
        if openN < n {
            stack.append("(") // ((
            backtrack(openN: openN + 1, closedN: closedN) // backtrack(1,0), backtrack(2,0)
            stack.popLast() // ((, (
        }
        
        if closedN < openN {
            stack.append(")") // (()), ()
            backtrack(openN: openN, closedN: closedN + 1) // backtrack(2,1), backtrack(2,2), backtrack(1,0)
            stack.popLast() // (()
        }
    }
    
    backtrack(openN: 0, closedN: 0) // backtrack(0,0)
    return result
    /*
     callstack:
     - backtrack(2,2) POPPED OFF
     - backtrack(2,1) (()
     - backtrack(2,0) ((
     - backtrack(1,0) (
     - backtrack(0,0)
     */
    
}

generateParenthesis(2)
