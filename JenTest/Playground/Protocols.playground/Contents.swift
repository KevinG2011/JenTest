import Foundation

enum Language { case english, german, croatian }

protocol Localizable {
    static var supportedLanguages: [Language] { get }
}

protocol MutableLocalizable: Localizable {
    mutating func change(to language: Language)
}

extension Localizable {
    static var supportedLanguages: [Language] {
        return [.english]
    }
}

protocol Greetable {
    func greet() -> String
}

extension Greetable {
    func greet() -> String {
        return "Hello"
    }
}

protocol Greeter: Greetable {}

struct GermanGreeter: Greeter {}
struct EnglishGreeter: Greeter {}

let englishGreeter: Greeter = EnglishGreeter()
let allGreeters: [Greeter] = [englishGreeter]

extension Array where Element: Greetable {
    var allGreetings: String {
        self.map{ $0.greet() }.joined()
    }
}

extension Array: Localizable where Element: Localizable {
    static var supportedLanguages: [Language] {
        Element.supportedLanguages
    }
}


