import Foundation

///类和结构体
struct Resolution {
    var width = 0
    var height = 0
}

//结构体和枚举类型都是值类型,在代码中传递的时候都会被复制
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd //隐式复制

cinema.width = 2048
print("cinema is now  \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")

///类是引用类型, 判定两个常量或者变量是否引用同一个类实例
class VideoMode {
var resolution = Resolution()
var interlaced = false
var frameRate = 0.0
var name: String?
}

let tenEighty = VideoMode()
let alsoTenEighty = tenEighty
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

///延时加载存储属性
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

///计算属性
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            //getter中忽略 return 与在函数中忽略 return 的规则相同
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
        }
        set {
            //简化set
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
    size: Size(width: 10.0, height: 10.0))
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

///只读计算属性
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

///属性观察器

class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("将 totalSteps 的值设置为 \(newValue)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("增加了 \(totalSteps - oldValue) 步")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200

///属性包装器
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)

/// 类型属性
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            currentLevel = min(currentLevel, AudioChannel.thresholdLevel)
            AudioChannel.maxInputLevelForAllChannels = max(currentLevel, AudioChannel.maxInputLevelForAllChannels)
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
print(AudioChannel.maxInputLevelForAllChannels)
rightChannel.currentLevel = 11
print(AudioChannel.maxInputLevelForAllChannels)
