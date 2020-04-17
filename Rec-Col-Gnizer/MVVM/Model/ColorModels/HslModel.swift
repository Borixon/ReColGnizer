//
//  HslModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit
import ColorWithHSL

class HslModel: ColorModel {
    
    typealias ColorData = (h: Int, s: Int, l: Int)
    static var maxValue: ColorData = (h: 359, s: 100, l: 100)
    var value: (h: Int, s: Int, l: Int)
    
    var color: UIColor {
        return UIColor.colorWithHSL(hue: CGFloat(value.h),
                                    saturation: CGFloat(value.s)/CGFloat(HslModel.maxValue.s),
                                    lightness: CGFloat(value.l)/CGFloat(HslModel.maxValue.l)) ?? .black
    }
    
    init(hue: Int, saturation: Int, lightness: Int) {
        value = (hue, saturation, lightness)
    }
    
    func toRgb() -> RgbModel {
        return RgbModel(r: 0, g: 0, b: 0)
    }
    
    func toHex() -> HexModel {
        return HexModel(value: "")
    }
}
