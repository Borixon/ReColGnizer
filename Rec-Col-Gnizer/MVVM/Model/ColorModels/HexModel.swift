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
    
    var components: [String] { return ["Hex"] } 
    
    var columnData: [String : (val: Int16, max: Int16)]? { return nil }
  
    var color: UIColor {
        return UIColor(hexString: value) ?? HexModel.defaultColor
    }
    
    var typeName: String {
        return "Hexadecimal"
    }
    
    init(value: String) {
        // Filter ? throw ?
        self.value = value.uppercased()
    }
    
    func toRgb() -> RgbModel {
        let color = UIColor(hexString: value) ?? HexModel.defaultColor
        var rComp: CGFloat = 0
        var gComp: CGFloat = 0
        var bComp: CGFloat = 0
        
        color.getRed(&rComp, green: &gComp, blue: &bComp, alpha: nil)
        
        return RgbModel(r: Int16(rComp), g: Int16(gComp), b: Int16(bComp))
    }
    
    func toHex() -> HexModel {
        return self
    }
    
    func toHsl() -> HslModel {
        // TODO
        return HslModel(h: 0, s: 0, l: 0)
    }
}
