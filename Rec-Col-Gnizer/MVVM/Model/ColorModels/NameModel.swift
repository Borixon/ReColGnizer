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
    
    typealias ColorData = (name: String, closestNamedHex: String?, exactMatch: Bool, distance: Int)
    static var maxValue: ColorData = ("name", "closestName", true, 0)
    var value: ColorData
    
    // TODO: wszystko
    var color: UIColor {
        return UIColor.red
    }
    
    init(name: String, closestNamedHex: String?, exactMatch: Bool, distance: Int) {
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
