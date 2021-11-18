import Foundation

func replaceNilValues<T>(from array:[T?], with element: T) -> [T] {
    array.compactMap { $0 == nil ? element : $0 }
}

let numbers: [Int?] = [32, 3, 24, nil, 4]
let filledNumbers = replaceNilValues(from: numbers, with: 0)
print(filledNumbers)


func max<T: Comparable>(lhs: T, rhs: T) -> T {
    return lhs > rhs ? lhs : rhs
}

///Generic types
class BaseNetworker {
    static func whoAmI() {
        print(self)
    }
}

BaseNetworker.whoAmI()

class WebsocketNetworker: BaseNetworker {
    static func whoAmI() -> BaseNetworker.Type {
        return self
    }
}

let type: BaseNetworker.Type = WebsocketNetworker.whoAmI()
print(type)
let networkerType: BaseNetworker.Type = BaseNetworker.self

