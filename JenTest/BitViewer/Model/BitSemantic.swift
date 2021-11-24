//
//  BitSemantic.swift
//  JenTest
//
//  Created by lijia on 2021/11/22.
//  Copyright © 2021 MJHF. All rights reserved.
//

enum BitSemantic: CaseIterable {
  case sign
  case exponent
  case significand

  static func provider<IntType: FixedWidthInteger>(for int: IntType.Type) -> (Int) -> Self? {
    return {
      bitIndex in
      int.isSigned && bitIndex == int.bitWidth - 1 ? .sign : nil
    }
  }

  static func provider<FloatType: BinaryFloatingPoint>(for floatType: FloatType.Type) -> (Int) -> Self {
    return { bitIndex in
      if bitIndex < FloatType.significandBitCount {
        return .significand
      } else if bitIndex < FloatType.significandBitCount + FloatType.exponentBitCount {
        return .exponent
      } else {
        return .sign
      }
    }
  }
}

