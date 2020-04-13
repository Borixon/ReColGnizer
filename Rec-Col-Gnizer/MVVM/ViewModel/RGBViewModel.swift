//
//  RGBViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class RGBViewModel: NSObject {
    
    private let model = RGBModel()
    public var delegate: RGBViewModelDelegate?
    public let mainColor = ColorRandomiezer.randomColor
    
    public var colorData: (red: Int, green: Int, blue: Int) {
        return (Int(selectedRed), Int(selectedGreen), Int(selectedBlue))
    }
    
    public var selectedRed: Float {
        get {
            return UserData().redRGBValue
        }
        set {
            UserData().redRGBValue = newValue
            delegate?.colorSet(color: ColorHelper().colorFrom(red: newValue, green: selectedGreen, blue: selectedBlue))
        }
    }
    
    public var selectedGreen: Float {
        get {
            return UserData().greenRGBValue
        }
        set {
            UserData().greenRGBValue = newValue
            delegate?.colorSet(color: ColorHelper().colorFrom(red: selectedRed, green: newValue, blue: selectedBlue))
        }
    }
    
    public var selectedBlue: Float {
        get {
            return UserData().blueRGBValue
        }
        set {
            UserData().blueRGBValue = newValue
            delegate?.colorSet(color: ColorHelper().colorFrom(red: selectedRed, green: selectedGreen, blue: newValue))
        }
    }
     
    public func getSelectedColor() -> UIColor {
        return ColorHelper().colorFrom(red: selectedRed, green: selectedGreen, blue: selectedBlue)
    }
    
    public func clangTextField(text: String?) -> String {
        guard let textValue = text else { return "0" }
        guard let value = Int(textValue) else { return "0" }
        if RGBModel.minRGB...RGBModel.maxRGB ~= value {
            return String(value)
        } else if value < RGBModel.minRGB {
            return String(RGBModel.minRGB)
        } else {
            return String(RGBModel.maxRGB)
        }
    }
    
    public func downloadRGBData(completion: @escaping (ColorModel?, Error?) -> ()) {
        WebService().getColorFrom(data: colorData, completion: { model, error in
            if model != nil {
                completion(model!, nil)
            } else if error != nil {
                completion(nil, error!)
            }
        })
    }
}

protocol RGBViewModelDelegate {
    func colorSet(color: UIColor)
    func openLoadingScreen()
    func hideLoadingScreen()
}
