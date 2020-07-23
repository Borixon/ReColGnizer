//
//  HslModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

class HslModel: ColorTypeModel {
    typealias ColorData = (h: Int16, s: Int16, l: Int16)
    static var maxValue: ColorData = (h: 360, s: 100, l: 100)
    var value: (h: Int16, s: Int16, l: Int16)
    
    var components: [String] {
        return ["H", "S", "L"]
    }
    
    var columnData: [String : (val: Int16, max: Int16)]? {
        let data = [components[0]: (val: value.h, max: HslModel.maxValue.h),
                    components[1]: (val: value.s, max: HslModel.maxValue.s),
                    components[2]: (val: value.l, max: HslModel.maxValue.l)]
        return data
    }
    
    var typeName: String {
        return "Hue Saturation Lightness"
    }
    
    var color: UIColor {
        let color = ColorHelper().hueToRgb(hue: value.h, saturation: value.s, lightness: value.l)
        return UIColor(displayP3Red: CGFloat(color.r) / CGFloat(RgbModel.maxValue.r),
                       green: CGFloat(color.g) / CGFloat(RgbModel.maxValue.g),
                       blue: CGFloat(color.b) / CGFloat(RgbModel.maxValue.b), alpha: 1)
    }
    
    var brightness: CGFloat {
        toRgb().brightness
    }
    
    init(h: Int16, s: Int16, l: Int16) {
        value = (h, s, l)
    }
    
    func toRgb() -> RgbModel {
        let values = ColorHelper().hueToRgb(hue: value.h, saturation: value.s, lightness: value.l)
        return RgbModel(r: values.r, g: values.g, b: values.b)
    }
    
    func toHex() -> HexModel {
        // TODO
        return HexModel(value: "")
    }
    
    func toHsl() -> HslModel {
        return self
    }
}
