//
//  DataDefaults.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class UserData {
    
    private let defaults = UserDefaults.standard
    
    private let kRedRGBValue = "kRGBRedValue"
    var redRGBValue: Float {
        get {
            if let rValue = defaults.value(forKey: kRedRGBValue) as? Float {
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
    var blueRGBValue: Float {
        get {
            if let rValue = defaults.value(forKey: kBlueRGBValue) as? Float {
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
    var greenRGBValue: Float {
        get {
            if let rValue = defaults.value(forKey: kGreenRGBValue) as? Float {
                return rValue
            } else {
                return 100
            }
        }
        set {
            defaults.setValue(newValue, forKey: kGreenRGBValue)
        }
    }
}
