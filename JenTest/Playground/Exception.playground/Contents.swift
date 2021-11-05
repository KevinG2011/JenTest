import Foundation

///表示错误状态
enum VendingMachineError: Error {
    case invalidSelection                       //选择无效
    case insufficientFunds(coinsNeeded: Int)    //金额不足
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws { //函数抛出错误
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}

//处理错误
let machine = VendingMachine()
machine.coinsDeposited = 1

do {
    try machine.vend(itemNamed: "hips")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}

enum FetchDataError: Error {
    case outOfDisk
    case timeout
}

///将错误转换成可选值
func fetchDataFromDisk() throws -> Data {
    throw FetchDataError.outOfDisk
}

func fetchDataFromServer() throws -> Data {
    throw FetchDataError.timeout
}

func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

if let _ = fetchData() {} else {
    print("no data")
}


///禁用错误传递
func loadImage(name:String) throws {
    print("never throws exception")
}
try! loadImage(name: "")

