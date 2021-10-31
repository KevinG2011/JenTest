import UIKit

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

///错误处理
func canThrowAnError() throws {}

do {
    try canThrowAnError()
    // 没有错误消息抛出
} catch {
    // 有一个错误消息抛出
}

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
