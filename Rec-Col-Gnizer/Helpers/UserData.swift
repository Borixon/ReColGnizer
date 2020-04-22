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
                return 100
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
                return 100
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
                return 100
            }
        }
        set {
            defaults.setValue(newValue, forKey: kGreenRGBValue)
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
    
    private let kDidUserSawTutorial = "kDidUserSawTutorial"
    var didShownTutorial: Bool {
        get {
            if let value = defaults.value(forKey: kDidUserSawTutorial) as? Bool {
                return value
            } else {
                return false
            }
        }
        set {
            defaults.setValue(newValue, forKey: kDidUserSawTutorial)
        }
    }
}
