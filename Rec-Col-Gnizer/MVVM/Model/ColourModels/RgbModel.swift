//
//  RgbModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class RgbModel: ColorTypeModel {
    
    typealias ColorData = (r: Int16, g: Int16, b: Int16)
    var value: ColorData
    
    var components: [String] {
        return ["R", "G", "B"]
    }
    
    var columnData: [String : (val: Int16, max: Int16)]? {
        let data = [components[0]: (val: value.r, max: RgbModel.maxValue.r),
                    components[1]: (val: value.g, max: RgbModel.maxValue.g),
                    components[2]: (val: value.b, max: RgbModel.maxValue.b)]
        return data
    }
    
    var typeName: String {
        return "Red Green Blue"
    }
    
    static var maxValue: ColorData {
        return (255, 255, 255)
    }
    
    var color: UIColor {
        let red =  CGFloat(value.r) / CGFloat(RgbModel.maxValue.r)
        let green =  CGFloat(value.g) / CGFloat(RgbModel.maxValue.g)
        let blue =  CGFloat(value.b) / CGFloat(RgbModel.maxValue.b)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
     
    var brightness: CGFloat {
        return CGFloat(Int64(value.r) * 299 + Int64(value.g) * 587 + Int64(value.b) * 114) / 1000.0
    }
    
    init(r: Int16, g: Int16, b: Int16) {
        value.r = r
        value.g = g
        value.b = b
    }
    
    func toRgb() -> RgbModel {
        return self
    }

    func toHex() -> HexModel {
        let hexValue =  String(format:"%02X", value.r) +
                        String(format:"%02X", value.g) +
                        String(format:"%02X", value.b)
        return HexModel(value: hexValue)
    }
    
    func toHsl() -> HslModel {
        let values = ColorHelper().rgbToHue(red: value.r, green: value.g, blue: value.b)
        return HslModel(h: values.h, s: values.s, l: values.l)
    }
}

