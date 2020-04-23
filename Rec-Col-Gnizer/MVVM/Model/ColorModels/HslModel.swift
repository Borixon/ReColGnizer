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

class HslModel: ColorTypeModel {
    
    typealias ColorData = (h: Int16, s: Int16, l: Int16)
    static var maxValue: ColorData = (h: 359, s: 100, l: 100)
    var value: (h: Int16, s: Int16, l: Int16)
    
    var typeName: String {
        return "Hue Saturation Lightness"
    }
    
    var color: UIColor {
        return UIColor.colorWithHSL(hue: CGFloat(value.h),
                                    saturation: CGFloat(value.s)/CGFloat(HslModel.maxValue.s),
                                    lightness: CGFloat(value.l)/CGFloat(HslModel.maxValue.l)) ?? .black
    }
    
    init(h: Int16, s: Int16, l: Int16) {
        value = (h, s, l)
    }
    
    func toRgb() -> RgbModel {
        // TODO:
        return RgbModel(r: Int16(0), g: Int16(0), b: Int16(0))
    }
    
    func toHex() -> HexModel {
        // TODO
        return HexModel(value: "")
    }
}
