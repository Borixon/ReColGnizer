//
//  PickerViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 14/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

final class PickerViewModel {
    
    public var delegate: PickerViewModelDelegate?
    private var rgbModel: RGB = RGB(r: 55, g: 23, b: 11, value: "", fraction: nil)
    
    var currentCategory: PickerViewCategory {
        return UserData().pickerCategory
    }
    
    var numberOfRows: Int {
        if currentCategory == PickerViewCategory.RGB || currentCategory == PickerViewCategory.HLS {
            return 3
        } else {
            return 4
        }
    }
    
    var rowHeight: CGFloat {
        return SliderCell.height
    }
    
    func getColor() {
        // TODO: Resolve this generic way
        if currentCategory == .RGB {
            requestColor(from: RGBRequestData(value: rgbModel))
        } else {
            
        }
    }
    
    private func requestColor<T: WSColorData>(from data: T) {
        WebService().getColorFrom(data: data, completion: { model, error in
            if model != nil {
                self.delegate?.show(color: model!)
            } else {
                self.delegate?.show(error: error)
            }
        })
    }
}

protocol PickerViewModelDelegate {
    func show(color: ColorModel)
    func show(error: Error?)
}

enum PickerViewCategory: String {
    case RGB = "RGBPickerViewCategory"
    case CMYK = "CMYKPickerViewCategory"
    case HLS = "HLSPickerViewCategory"
}
