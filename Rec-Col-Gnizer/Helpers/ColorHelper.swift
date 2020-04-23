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
    
    func hueToRgb(hue: Int16, saturation: Int16, lightness: Int16) {
        
    }
    
    func rgbToHue(red: Int16, green: Int16, blue: Int16) {
        
//          r /= 255;
//          g /= 255;
//          b /= 255;
//          var max = Math.max(r, g, b);
//          var min = Math.min(r, g, b);
//          var c   = max - min;
//          var hue;
//          if (c == 0) {
//            hue = 0;
//          } else {
//            switch(max) {
//              case r:
//                var segment = (g - b) / c;
//                var shift   = 0 / 60;       // R° / (360° / hex sides)
//                if (segment < 0) {          // hue > 180, full rotation
//                  shift = 360 / 60;         // R° / (360° / hex sides)
//                }
//                hue = segment + shift;
//                break;
//              case g:
//                var segment = (b - r) / c;
//                var shift   = 120 / 60;     // G° / (360° / hex sides)
//                hue = segment + shift;
//                break;
//              case b:
//                var segment = (r - g) / c;
//                var shift   = 240 / 60;     // B° / (360° / hex sides)
//                hue = segment + shift;
//                break;
//            }
//          }
//          return hue * 60; // hue is in [0,6], scale it up
//        }
    }
    
    func colorWithHSL(hue: CGFloat, saturation: CGFloat, lightness: CGFloat) -> UIColor? {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        
        guard hue <= 360 && hue >= 0.0 else { return nil }
        guard saturation <= 1.0 && saturation >= 0.0 else { return nil }
        guard lightness <= 1.0 && lightness >= 0.0 else { return nil }
        
        let chroma: CGFloat = (1 - abs((2 * lightness) - 1)) * saturation
        let h60: CGFloat = hue / 60.0
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
        
        let m: CGFloat = lightness - (chroma / 2)
        
        r = r + m
        g = g + m
        b = b + m
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
