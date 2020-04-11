//
//  RGBModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

class RGBModel {
    
    static let maxRGB: Int = 255
    static let minRGB: Int = 0
  
    typealias N = BinaryFloatingPoint
//
//    static func fraction<T: BinaryInteger>(value: T) -> T {
//
//        if N(RGBModel.minRGB)...N(RGBModel.maxRGB) ~= N(value) {
////            return CGFloat(value) / CGFloat(RGBModel.maxRGB)
//        }
//        return value < RGBModel.minRGB ? 0 : 1
//    }
    
    static func fraction<T: BinaryFloatingPoint>(value: T) -> T {
        if T(RGBModel.minRGB)...T(RGBModel.maxRGB) ~= value {
            return value / T(RGBModel.maxRGB)
        }
        return value < T(RGBModel.minRGB) ? 0 : 1
    }
}
