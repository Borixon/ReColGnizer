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
    
    static var maxValue: ColorData {
        return (255, 255, 255)
    }
    
    var color: UIColor {
        let red =  CGFloat(value.r) / CGFloat(RgbModel.maxValue.r)
        let green =  CGFloat(value.g) / CGFloat(RgbModel.maxValue.g)
        let blue =  CGFloat(value.b) / CGFloat(RgbModel.maxValue.b)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
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
}

