//
//  RgbModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class RgbModel: ColorModel {
    
    typealias ColorData = (r: Int, g: Int, b: Int)
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
    
    init(r: Int, g: Int, b: Int) {
        value.r = r
        value.g = g
        value.b = b
    }
    
    init(r: Float, g: Float, b: Float) {
        value.r = Int(r * Float(RgbModel.maxValue.r))
        value.g = Int(g * Float(RgbModel.maxValue.g))
        value.b = Int(b * Float(RgbModel.maxValue.b))
    }
    
    init(r: CGFloat, g: CGFloat, b: CGFloat) {
        value.r = Int(r * CGFloat(RgbModel.maxValue.r))
        value.g = Int(g * CGFloat(RgbModel.maxValue.g))
        value.b = Int(b * CGFloat(RgbModel.maxValue.b))
    }
    
    func toRgb() -> RgbModel {
        return self
    }

    func toHex() -> HexModel {
        return HexModel(value: "12ffcc")
    }
}

