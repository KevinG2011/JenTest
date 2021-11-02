import Foundation

enum CompassPoint {
    case north, south
    case east
    case west
}
var directionToHead = CompassPoint.west
//类型推断
directionToHead = .east

///关联值
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
switch productBarcode {
  case let .upc(numberSystem, manufacturer, product, check):
      //提取所有值为常量
      print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
  case let .qrCode(productCode):
      print("QR code: \(productCode).")
}

///原始值
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

enum Intensity: Int {
    case low, medium, high
}

let highOrder = Intensity.high.rawValue
let possibleIntensity = Intensity(rawValue: 0)

///递归枚举
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
