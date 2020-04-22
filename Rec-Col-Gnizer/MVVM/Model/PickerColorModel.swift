//
//  RGBModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

class PickerColorModel {
     
    var rgbModel: RgbModel = RgbModel(r: UserData().redRGBValue, g: UserData().greenRGBValue, b: UserData().blueRGBValue)
    var hexModel: HexModel = HexModel(value: "")
    var hslModel: HslModel = HslModel(h: 0, s: 80, l: 50)
    
    var schemeOptions: Dictionary<String, String> = Dictionary()
     
    var isScheme: Bool {
        if schemeOptions.count == 0 {
            return false
        }
        return true
    } 
}
