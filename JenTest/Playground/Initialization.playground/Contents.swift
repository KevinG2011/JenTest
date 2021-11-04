import Foundation

///不带实参标签的构造器形参
struct Celsius {
    var temperatureInCelsius: Double
    init(_ celsius: Double){ //忽略标签
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius(37.0)


struct Size {
    var width = 0.0, height = 0.0
}
let twoBytwo = Size(height: 0.0)

///指定构造器和便利构造器
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }

    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

///可失败构造器
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

///必要构造器
class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}

///闭包或函数设置属性的默认值
struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
