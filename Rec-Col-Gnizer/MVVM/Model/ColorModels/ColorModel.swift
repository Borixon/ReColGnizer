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
    
    init(color: WSColorModel) {
        rgb = color.rgb.toModel()
        cmyk = color.cmyk.toModel()
        hsl = color.hsl.toModel()
        hex = color.hex.toModel()
        name = color.name.toModel()
        contrast = color.contrast.toModel()
    }
    
}
