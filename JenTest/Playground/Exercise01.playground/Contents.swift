import Foundation
import UIKit

struct Email: RawRepresentable {
    var rawValue: String
    
    init?(rawValue: String) {
        guard rawValue.contains("@") else { return nil }
        self.rawValue = rawValue
    }
}

struct PermutedCongruential: RandomNumberGenerator {
    private var state: UInt64
    private let multiplier: UInt64 = 6364136223846793005
    private let increment: UInt64 = 1442695040888963407
    
    private func rotr32(x: UInt32, r: UInt32) -> UInt32 {
        (x &>> r) | x &<< ((~r &+ 1) & 31)
    }
    
    private mutating func next32() -> UInt32 {
        var x = state
        let count = UInt32(x &>> 59)
        state = x &* multiplier &+ increment
        x ^= x &>> 18
        return rotr32(x: UInt32(truncatingIfNeeded: x &>> 27), r: count)
    }
    
    mutating func next() -> UInt64 {
        UInt64(next32()) << 32 | UInt64(next32())
    }
    
    init(seed: UInt64) {
        state = seed &+ increment
        _ = next()
    }
}


struct Point: Equatable {
    var x,y:Double
    static var zero: Point {
        Point(x: 0, y: 0)
    }
}

extension Point {
    func flipped() -> Point {
        Point(x: self.y, y: self.x)
    }
    
    mutating func flip() {
        self = flipped()
    }
}

extension Point {
    static func random(inRadius raduis:Double, using randomSource: inout PermutedCongruential) -> Point {
        guard raduis >= 0 else {
            return .zero
        }
        
        let x = Double.random(in: -raduis...raduis, using: &randomSource)
        let maxY = (raduis * raduis - x * x).squareRoot()
        let y = Double.random(in: -maxY...maxY, using: &randomSource)
        return Point(x: x, y: y)
    }
}

var pcg = PermutedCongruential(seed: 1234)
//for _ in 1...10 {
//    let p = Point.random(inRadius: 1, using: &pcg)
//}

typealias Angle = Measurement<UnitAngle>

extension Angle {
    init(radius: Double) {
        self = Angle(value: radius, unit: .radians)
    }
    
    init(degrees: Double) {
        self = Angle(value: degrees, unit: .degrees)
    }
    var radians: Double {
        converted(to: .radians).value
    }
    
    var degrees: Double {
        converted(to: .degrees).value
    }
}

func cos(_ angle: Angle) -> Double {
    cos(angle.radians)
}

func sin(_ angle: Angle) -> Double {
    sin(angle.radians)
}

struct Polar: Equatable {
    var angle: Angle
    var distance: Double
}

extension Polar {
    init(_ point: Point) {
        self.init(angle: Angle(radius: atan2(point.y, point.x)),
                  distance: hypot(point.x, point.y))
    }
}

extension Point {
    init(_ polar: Polar) {
        self.init(x: polar.distance * cos(polar.angle),
                  y: polar.distance * sin(polar.angle))
    }
}

enum Quadrant: CaseIterable, Hashable {
    case i, ii, iii, iv
    
    init?(_ point: Point) {
        guard !point.x.isZero && !point.y.isZero else {
            return nil
        }
        
        switch (point.x.sign, point.y.sign) {
        case (.plus, .plus):
            self = .i
        case (.minus, .plus):
            self = .ii
        case (.minus, .minus):
            self = .iii
        case (.plus, .minus):
            self = .iv
        }
    }
}

extension Quadrant {
    init?(polar: Polar) {
        let p = Point(polar)
        self.init(p)
    }
}

assert(Quadrant(Point(x: 10, y: -3)) == Quadrant.iv)

pcg = PermutedCongruential(seed: 4321)
for _ in 1...100 {
    Point.random(inRadius: 1, using: &pcg)
}

let v = Measurement(value: 1.5, unit: UnitVolume.liters)
let c = v.converted(to: .cups)
print(c)
