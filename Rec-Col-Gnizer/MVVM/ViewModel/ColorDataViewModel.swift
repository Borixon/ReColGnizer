//
//  ColorDataViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 11/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import SwiftHEXColors

class ColorDataViewModel: NSObject {

    private let model: ColorModel
    public let nameCellIndentifier = "ColorCellNameIdentifier"
    public let rgbCellIdentifier = "rgbCellIdentifier"
    
    init(model: ColorModel) {
        self.model = model
    }
    
    var contrastColor: UIColor {
        return UIColor(hexString: model.contrast.value) ?? .black
    }
    
    var color: UIColor {
        return UIColor(hexString: model.hex.value) ?? .white
    }
    
    var closestDefinedColor: UIColor {
        if model.name.exact_match_name {
            return UIColor(hexString: model.hex.value) ?? .white
        } else {
            return UIColor(hexString: model.name.closest_named_hex) ?? .white
        }
    }
    
    var numberOfRows: Int {
        if model.name.exact_match_name {
            return 4
        } else {
            return 5
        }
    }
    
    var nameData: (name: String, hex: String) {
        return (model.name.value, model.hex.value)
    }
    
    var rgbData: RGB {
        return model.rgb
    }
    
    var cmykData: CMYK {
        return model.cmyk
    }
}
