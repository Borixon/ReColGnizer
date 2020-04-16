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

    private let model: WSColorModel
    public let nameCellIndentifier = "ColorCellNameIdentifier"
    public let rgbCellIdentifier = "rgbCellIdentifier"
    
    init(model: WSColorModel) {
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
    
    var rgbData: WSRgbModel {
        return model.rgb
    }
    
    var cmykData: WSCmykModel {
        return model.cmyk
    }
}
