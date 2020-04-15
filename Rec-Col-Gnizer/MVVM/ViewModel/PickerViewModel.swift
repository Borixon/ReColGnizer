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
}

enum PickerViewCategory: String {
    case RGB = "RGBPickerViewCategory"
    case CMYK = "CMYKPickerViewCategory"
    case HLS = "HLSPickerViewCategory"
}
