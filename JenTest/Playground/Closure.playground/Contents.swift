import Foundation
///闭包
let unnames = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//参数名称缩写
print(unnames.sorted(by: { $0 > $1 }))

//运算符方法
unnames.sorted { $0 < $1 } //()可以省略

//尾随闭包
func trailingClosure(closure: () -> Void) {
//    closure()
}

trailingClosure {
    print("trailing closure test")
}

// map尾随
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

numbers.map { number -> String in
    var output = ""
    var num = number
    repeat {
        guard let digit = digitNames[num % 10] else {
            continue
        }
        output = digit + output;
        num /= 10;
    } while num > 0
    return output
}

// 自动闭包
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure @escaping () -> String) {
    print("Now serving \(customerProvider())!")
}
//延时求值
serve(customer: customersInLine.remove(at: 0))

