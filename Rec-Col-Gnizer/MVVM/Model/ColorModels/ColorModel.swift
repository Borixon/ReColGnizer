//
//  ColorModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class ColorModel: NSObject {
    
    let rgb: RgbModel
    let cmyk: CmykModel
    let hsl: HslModel
    let hex: HexModel
    let name: NameModel
    let contrast: HexModel
    let derivedColor: ColorModel? = nil
    let exactColor: ColorModel? = nil
    
    init(color: WSColorModel) {
        rgb = color.rgb.toModel()
        cmyk = color.cmyk.toModel()
        hsl = color.hsl.toModel()
        hex = color.hex.toModel()
        name = color.name.toModel()
        contrast = color.contrast.toModel()
    }
    
    init(color: ColorEntity) {
        rgb = color.rgb?.toModel() ?? RgbModel(r: Int16(0), g: Int16(0), b: Int16(0))
        cmyk = color.cmyk?.toModel() ?? CmykModel(c: 0, m: 0, y: 0, k:  0)
        hsl = color.hsl?.toModel() ?? HslModel(h: 0, s: 0, l: 0)
        hex = HexModel(value: color.hex)
        name = NameModel(name: color.name, closestNamedHex: color.exactColor?.hex, exactMatch: color.exactMatch, distance: color.distance)
        contrast = HexModel(value: color.contrast)
    }
    
}
