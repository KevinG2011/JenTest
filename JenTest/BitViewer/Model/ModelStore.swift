//
//  ModelStore.swift
//  JenTest
//
//  Created by lijia on 2021/11/22.
//  Copyright © 2021 MJHF. All rights reserved.
//

import Foundation
import CoreGraphics

final class ModelStore {
   var selection: TypeSelection = .int8

   var int8: Int8 = 10
   var uint8: UInt8 = 10
   var int16: Int16 = 10
   var uint16: UInt16 = 10
   var int32: Int32 = 10
   var uint32: UInt32 = 10
   var int64: Int64 = 10
   var uint64: UInt64 = 10
   var int: Int = 10
   var uint: UInt = 10

//   var float16: Float16 = 1.0
   var float32: Float32 = 1.0
   var float64: Float64 = 1.0
   var float: Float = 1.0
   var double: Double = 1.0
   var cgFloat: CGFloat = 1.0
}
