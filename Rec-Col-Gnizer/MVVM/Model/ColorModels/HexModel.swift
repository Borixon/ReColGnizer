//
//  HexModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

class HexModel: ColorTypeModel {
    
    typealias ColorData = String
    
    static let hexLenght: Int = 6
    static let defaultColor: UIColor = .lightText
    static var maxValue: ColorData = "0123456789abcdef"
    var value: String
  
    var color: UIColor {
        return UIColor(hexString: value) ?? HexModel.defaultColor
    }
    
    init(value: String) {
        // Filter ? throw ?
        self.value = value.lowercased()
    }
    
    func toRgb() -> RgbModel {
        let color = UIColor(hexString: value) ?? HexModel.defaultColor
        var rComp: CGFloat = 0
        var gComp: CGFloat = 0
        var bComp: CGFloat = 0
        
        color.getRed(&rComp, green: &gComp, blue: &bComp, alpha: nil)
        
        return RgbModel(r: rComp, g: gComp, b: bComp)
    }
    
    func toHex() -> HexModel {
        return self
    }

    static func isValid(hex: String) -> Bool {
        let lowHex = hex.lowercased()
        guard lowHex.count == 6 else { return false }
        let regex = try! NSRegularExpression(pattern: "^[0-9a-f]{6}", options: [])
        return regex.firstMatch(in: lowHex, options: [], range: NSRange(location: 0, length: 6)) != nil
    }
}
