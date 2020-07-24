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
    var components: [String] { get }
    var columnData: [String : (val: Int16, max: Int16)]? { get }
    var value: ColorData { get set }
    var typeName: String { get }
    var color: UIColor { get }
    var brightness: CGFloat { get }
    
    func toRgb() -> RgbModel
    func toHex() -> HexModel
    func toHsl() -> HslModel
    
}
