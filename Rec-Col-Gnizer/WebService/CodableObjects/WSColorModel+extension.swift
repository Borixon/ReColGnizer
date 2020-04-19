//
//  WSColorModel+extension.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

protocol ModelConverter {
    associatedtype ReturnModel
    func toModel() -> ReturnModel
}

extension WSColorModel {
    
}

extension WSRgbModel: ModelConverter {
    typealias ReturnModel = RgbModel
    func toModel() -> RgbModel {
        return RgbModel(r: r, g: g, b: b)
    }
}

extension WSHslModel: ModelConverter {
    typealias ReturnModel = HslModel
    func toModel() -> HslModel {
        return HslModel(hue: h, saturation: s, lightness: l)
    }
}

extension WSCmykModel: ModelConverter {
    typealias ReturnModel = CmykModel
    func toModel() -> CmykModel {
        return CmykModel(c: c ?? 0, m: m ?? 0, y: y ?? 0, k: k ?? 0)
    }
}

extension WSHexModel: ModelConverter {
    typealias ReturnModel = HexModel
    func toModel() -> HexModel {
        return HexModel(value: value)
    }
}

extension WSColorNameModel: ModelConverter {
    typealias ReturnModel = NameModel
    func toModel() -> NameModel {
        return NameModel(name: value, closestNamedHex: closest_named_hex, exactMatch: exact_match_name, distance: distance)
    }
}

extension WSContrastColorModel: ModelConverter {
    typealias ReturnModel = HexModel
    func toModel() -> HexModel {
        return HexModel(value: value)
    }
}
