//
//  ColorHelper.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

final class ColorHelper: NSObject {
    
    static let invalidHexValueTitle = "Invalid hexadecimal value!"
    static let invalidHexValueInfo = "Given value must contain digits or letters between a - f and must consist of six or three components"
    
    static func isHexValid(hex: String) -> Bool {
        let lowHex = hex.lowercased()
        guard lowHex.count == 6 else { return false }
        let regex = try! NSRegularExpression(pattern: "^[0-9a-f]{6}", options: [])
        return regex.firstMatch(in: lowHex, options: [], range: NSRange(location: 0, length: 6)) != nil
    }
    
    func hueToRgb(hue: Int16, saturation: Int16, lightness: Int16) -> (r: Int16, g:Int16, b:Int16) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        let sat: CGFloat = CGFloat(saturation) / 100.0
        let light: CGFloat = CGFloat(lightness) / 100.0
        let chroma: CGFloat = (1 - abs((2 * light) - 1)) * sat
        let h60: CGFloat = CGFloat(hue) / 60.0
        let x: CGFloat = chroma * (1 - abs((h60.truncatingRemainder(dividingBy: 2)) - 1))
        
        if (h60 < 1) {
            r = chroma
            g = x
        } else if (h60 < 2) {
            r = x
            g = chroma
        } else if (h60 < 3) {
            g = chroma
            b = x
        }  else if (h60 < 4) {
            g = x
            b = chroma
        } else if (h60 < 5) {
            r = x
            b = chroma
        } else if (h60 < 6) {
            r = chroma
            b = x
        }
        
        let m: CGFloat = light - (chroma / 2)
        
        r = r + m
        g = g + m
        b = b + m
        
        return (r: Int16(r * CGFloat(RgbModel.maxValue.r)),
                g: Int16(g * CGFloat(RgbModel.maxValue.g)),
                b: Int16(b * CGFloat(RgbModel.maxValue.b)))
    }
    
    func rgbToHue(red: Int16, green: Int16, blue: Int16) -> (h: Int16, s: Int16, l: Int16) {
        
        let r = CGFloat(red) / CGFloat(RgbModel.maxValue.r)
        let g = CGFloat(green) / CGFloat(RgbModel.maxValue.g)
        let b = CGFloat(blue) / CGFloat(RgbModel.maxValue.b)
        let maxVal = max(r, g, b)
        let minVal = min(r, g, b)
        
        let lightness = ((maxVal + minVal) / 2)
        
        var saturation: CGFloat
        if r == b && b == g {
            saturation = 0
        } else {
            if lightness < 0.5 {
                saturation = (maxVal - minVal) / (maxVal + minVal)
            } else {
                saturation = (maxVal - minVal) / (2.0 - maxVal - minVal)
            }
        }
        
        var hue: CGFloat = 0
        if maxVal - minVal != 0 {
            if maxVal == r {
                hue = (g - b) / (maxVal - minVal)
            } else if maxVal == g {
                hue = 2.0 + (b - r) / (maxVal - minVal)
            } else if maxVal == b {
                hue = 4.0 + (r - g) / (maxVal - minVal)
            }
        }
        
        hue = hue * 60
        
        if hue < 0 {
            hue = hue + CGFloat(HslModel.maxValue.h)
        }
        
        return (h: Int16(hue),
                s: Int16(saturation * CGFloat(HslModel.maxValue.s)),
                l: Int16(lightness * CGFloat(HslModel.maxValue.l)))
    }

}
