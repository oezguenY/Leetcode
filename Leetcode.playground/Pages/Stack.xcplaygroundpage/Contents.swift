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

