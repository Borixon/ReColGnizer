//
//  SliderCellData.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

protocol SliderCellData {
    var type: SliderCellType { get set }
    var value: Float { get set }
    var minValue: Float { get set }
    var maxValue: Float { get set }
}
 

struct SliderData: SliderCellData {
    var value: Float
    var minValue: Float
    var maxValue: Float
    var type: SliderCellType
    
    init(min: Float = 0, max: Float, current: Float, type: SliderCellType) {
        minValue = min
        maxValue = max
        value = current
        self.type = type
    }
}
