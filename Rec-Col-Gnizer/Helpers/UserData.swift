//
//  DataDefaults.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class UserData: NSObject {
    
    private let defaults = UserDefaults.standard
    
    private let kRedRGBValue = "kRGBRedValue"
    var redRGBValue: Int16 {
        get {
            if let rValue = defaults.value(forKey: kRedRGBValue) as? Int16 {
                return rValue
            } else {
                return 202
            }
        }
        set {
            defaults.setValue(newValue, forKey: kRedRGBValue)
        }
    }
    
    private let kBlueRGBValue = "kRGBBlueValue"
    var blueRGBValue: Int16 {
        get {
            if let rValue = defaults.value(forKey: kBlueRGBValue) as? Int16 {
                return rValue
            } else {
                return 91
            }
        }
        set {
            defaults.setValue(newValue, forKey: kBlueRGBValue)
        }
    }
    
    private let kGreenRGBValue = "kRGBGreenValue"
    var greenRGBValue: Int16 {
        get {
            if let rValue = defaults.value(forKey: kGreenRGBValue) as? Int16 {
                return rValue
            } else {
                return 91
            }
        }
        set {
            defaults.setValue(newValue, forKey: kGreenRGBValue)
        }
    }
    
    private let kHueHSLValue = "kHueHSLValue"
    var hue: Int16 {
        get {
            if let val = defaults.value(forKey: kHueHSLValue) as? Int16 {
                return val
            } else {
                return 127
            }
        }
        set {
            defaults.setValue(newValue, forKey: kHueHSLValue)
        }
    }
    
    private let kSaturationHSLValue = "kSaturationHSLValue"
    var saturation: Int16 {
        get {
            if let val = defaults.value(forKey: kSaturationHSLValue) as? Int16 {
                return val
            } else {
                return 78
            }
        }
        set {
            defaults.setValue(newValue, forKey: kSaturationHSLValue)
        }
    }
    
    private let kLightnessHSLValue = "kLightnessHSLValue"
    var lightness: Int16 {
        get {
            if let val = defaults.value(forKey: kLightnessHSLValue) as? Int16 {
                return val
            } else {
                return 78
            }
        }
        set {
            defaults.setValue(newValue, forKey: kLightnessHSLValue)
        }
    }
    
    private let kPickerCategorySelected = "kPickerCategorySelected"
    var selectedPickerCategory: PickerCategory {
        get {
            if let value = PickerCategory(rawValue: defaults.string(forKey: kPickerCategorySelected) ?? "") {
                return value
            } else {
                return PickerCategory.Rgb
            }
        }
        set {
            defaults.setValue(newValue.rawValue, forKey: kPickerCategorySelected)
        }
    }
    
    private let kUserShouldSeeColorHint = "kUserShouldSeeColorHint"
    var userShouldSeeColorHint: Bool {
        get {
            if let value = defaults.value(forKey: kUserShouldSeeColorHint) as? Bool {
                return value
            } else {
                return true
            }
        }
        set {
            defaults.setValue(newValue, forKey: kUserShouldSeeColorHint)
        }
    }
}
