//
//  CmykModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

class CmykModel: ColorTypeModel {
    
    typealias ColorData = (c: Int16, m: Int16, y: Int16, k: Int16)
    static var maxValue: (c: Int16, m: Int16, y: Int16, k: Int16) = (100, 100, 100, 100)
    var value: (c: Int16, m: Int16, y: Int16, k: Int16)
    
    var components: [String] {
        return ["C", "M", "Y", "K"]
    }
    
    var columnData: [String : (val: Int16, max: Int16)]? {
        let data = [components[0]: (val: value.c, max: CmykModel.maxValue.c),
                    components[1]: (val: value.m, max: CmykModel.maxValue.m),
                    components[2]: (val: value.y, max: CmykModel.maxValue.y),
                    components[3]: (val: value.k, max: CmykModel.maxValue.k)]
        return data
    }
    
    var color: UIColor {
        return UIColor.red
    }
    
    var typeName: String {
        return "Cyan Magenta Yellow Key"
    }
    
    init(c: Int16, m: Int16, y: Int16, k: Int16) {
        value.c = c
        value.m = m
        value.y = y
        value.k = k
    }
    
    func toRgb() -> RgbModel {
        return RgbModel(r: 0, g: 0, b: 0)
    }
    
    func toHex() -> HexModel {
        return HexModel(value: "FF0000")
    }
}
