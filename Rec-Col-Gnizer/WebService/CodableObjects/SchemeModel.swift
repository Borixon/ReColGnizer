//
//  SchemeModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 15/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

struct ColorSchemeModel: Codable {
    let mode: String
    let count: String
    let colors: Array<ColorModel>
    let seed: ColorModel
}
