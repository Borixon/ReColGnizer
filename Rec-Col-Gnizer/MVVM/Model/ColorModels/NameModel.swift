//
//  NameModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

class NameModel: ColorTypeModel {
    
    typealias ColorData = (name: String, closestNamedHex: String?, exactMatch: Bool, distance: Int16)
    static var maxValue: ColorData = ("name", "closestName", true, 0)
    var value: ColorData
    
    var components: [String] { return ["Name", "Closest named hexadecimal", "Exact match", "Distance"] }
    
    var columnData: [String : (val: Int16, max: Int16)]? { return nil }
    
    var color: UIColor {
        return UIColor.red
    }
    
    var typeName: String {
        return "Color name"
    }
    
    init(name: String, closestNamedHex: String?, exactMatch: Bool, distance: Int16) {
        value.name = name
        value.closestNamedHex = closestNamedHex
        value.exactMatch = exactMatch
        value.distance = distance
    }
    
    func toRgb() -> RgbModel {
        // TODO
        return RgbModel(r: 0, g: 0, b: 0)
    }
    
    func toHex() -> HexModel {
        // TODO
        return HexModel(value: "")
    }
    
    
}
