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
    
    typealias ColorData = (c: Int16, m: Int16, y: Int16, k: Int16)
    static var maxValue: (c: Int16, m: Int16, y: Int16, k: Int16) = (100, 100, 100, 100)
    var value: (c: Int16, m: Int16, y: Int16, k: Int16)
    
    var color: UIColor {
        return UIColor.red
    }
    
    init(c: Int16, m: Int16, y: Int16, k: Int16) {
        value.c = c
        value.m = m
        value.y = y
        value.k = k
    }
    
    func toRgb() -> RgbModel {
        return RgbModel(r: 0, g: 0, b: 0)
    }
    
    func toHex() -> HexModel {
        return HexModel(value: "FF0000")
    }
    
    
    
}
