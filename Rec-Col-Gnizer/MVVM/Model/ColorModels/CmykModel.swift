//
//  CmykModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

class CmykModel: ColorTypeModel {
    
    typealias ColorData = (c: Int, m: Int, y: Int, k: Int)
    static var maxValue: (c: Int, m: Int, y: Int, k: Int) = (100, 100, 100, 100)
    var value: (c: Int, m: Int, y: Int, k: Int)
    
    var color: UIColor {
        return UIColor.red
    }
    
    init(c: Int, m: Int, y: Int, k: Int) {
        value.c = c
        value.m = m
        value.y = y
        value.k = k
    }
    
    func toRgb() -> RgbModel {
        return RgbModel(r: 255, g: 0, b: 0)
    }
    
    func toHex() -> HexModel {
        return HexModel(value: "FF0000")
    }
    
    
    
}
