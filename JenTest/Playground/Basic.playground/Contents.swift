import UIKit
import Foundation

/// 基础部分

/// 类型别名
typealias AudioSample = UInt16

/// 元组
let http404Error = (404, "Not Found")
// http404Error 的类型是 (Int, String)，值是 (404, "Not Found")
// 元组的内容分解（decompose)
let (statusCode, _) = http404Error
print("The status code is \(statusCode)")
print("The status code is \(http404Error.0), \(http404Error.1)")
let http200Status = (statusCode: 200, description: "OK")

/// 强制解析
// 使用 ! 来获取一个不存在的可选值会导致运行时错误。使用 ! 来强制解析值之前，一定要确定可选包含一个非 nil 的值。
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要感叹号来获取值

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 不需要感叹号

/// 错误处理
func canThrowAnError() throws {}

do {
    try canThrowAnError()
    // 没有错误消息抛出
} catch {
    // 有一个错误消息抛出
}

///闭区间运算符
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names[2...] {
    print(name)
}

///Array
var shoppingList = ["Eggs", "Milk"]
shoppingList[0..<2] = ["Bananas", "Apples"]
let apples = shoppingList.removeLast()
for (index, value) in shoppingList.enumerated() {
    print("Item \(String(index + 1)): \(value)")
}

///Set
var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
favoriteGenres.insert("Jazz")
for genre in favoriteGenres.sorted() {
    print("\(genre)")
}

///Dictionary
var namesOfIntegers: [Int: String] = [:]
namesOfIntegers[16] = "sixteen"
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
airports["DUB"] = nil
print(airports.count)

for (key, value) in airports {
  print("\(key):\(value)");
}

/// 控制流
//提前退出
var i = 0;
func greet(person: [String: String]) {
  guard i > 0 else {
    return
  }
}

repeat {
  print("i = \(i)");
  i += 1
} while i < 5

//where条件
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// 输出“(1, -1) is on the line x == -y”

//复合型case
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
// 输出“On an axis, 9 from the origin”

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

//带标签的语句
//label name: while condition {
//    statements
//}

///可变参数
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

///输入输出参数

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
  let ta = a;
  a = b;
  b = ta;
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("\(someInt), \(anotherInt)")

///嵌套函数
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
let curval = 8
chooseStepFunction(backward: curval > 0)(curval)











exit(0)

enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
case let .failure(message):
    print("Failure...  \(message)")
}

switch failure {
case let .result(sunrise, sunset):
  print("\(sunrise), \(sunset)")
case let .failure(message):
  print("Failure... \(message)")
}
