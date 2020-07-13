//
//  CellBuidler.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 11/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

struct CellDataBuilder {

    public func getSliderCell<T: ColorTypeModel>(forRow row: Int, model: T) -> SliderData? {
        if let rgb = model as? RgbModel {
            if row == 0 {
                return SliderData(max: Float(RgbModel.maxValue.r),
                                  current: Float(rgb.value.r),
                                  type: SliderCellType.Red)
            } else if row == 1 {
                return SliderData(max: Float(RgbModel.maxValue.g),
                                  current: Float(rgb.value.g),
                                  type: SliderCellType.Green)
            } else {
                return SliderData(max: Float(RgbModel.maxValue.b),
                                  current: Float(rgb.value.b),
                                  type: SliderCellType.Blue)
            }
        } else if let hsl = model as? HslModel {
            if row == 0 {
                return SliderData(max: Float(HslModel.maxValue.h),
                                  current: Float(hsl.value.h),
                                  type: SliderCellType.Hue)
            } else if row == 1 {
                return SliderData(max: Float(HslModel.maxValue.s),
                                  current: Float(hsl.value.s),
                                  type: SliderCellType.Saturation)
            } else {
                return SliderData(max: Float(HslModel.maxValue.l),
                                  current: Float(hsl.value.l),
                                  type: SliderCellType.Lightness)
            }
        }
        return nil
    }
    
}
