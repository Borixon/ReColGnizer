//
//  ColorModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

protocol ColorTypeModel {
    associatedtype ColorData
    
    static var maxValue: ColorData { get }
    var value: ColorData { get set }
    var color: UIColor { get }
    
    func toRgb() -> RgbModel
    func toHex() -> HexModel
    
//    Next episode
//    func toCmyk() -> RgbModel
//    func toHsl() -> RgbModel
}
