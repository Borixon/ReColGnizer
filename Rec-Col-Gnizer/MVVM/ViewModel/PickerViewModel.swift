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
    
    public let sliderCellIdentifier = "sliderCellIdentifier"
    public var delegate: PickerViewModelDelegate?
    private var model: PickerColorModel = PickerColorModel()
    
    var searchPicker: PickerCategory = UserData().pickerCategory
    
    var viewCategory: PickerCategory {
        get {
            return UserData().pickerCategory
        }
        set {
            UserData().pickerCategory = newValue
        }
    }
    
    var numberOfRows: Int {
        // TODO: Switch?
        if viewCategory == PickerCategory.Rgb || viewCategory == PickerCategory.Hsl {
            return 3
        } else {
            return 4
        }
    }
    
    var rowHeight: CGFloat {
        return SliderCell.height
    }
     
    var selectedColor: UIColor {
        if viewCategory == .Rgb {
            return model.rgbModel.color
        } else if viewCategory == .Hsl {
            return model.hslModel.color
        }
        return .red
    }
    
    public func search(hex: String) {
        guard HexModel.isValid(hex: hex) else {
            // TODO: Print alert not valid hex
            return
        }
        model.hexModel = HexModel(value: hex)
        searchPicker = .Hex
        sendDataRequest()
    }
    
    public func sliderDataChange(_ value: Float, type: SliderCellType) {
        let val = Int(value)
        switch type {
        case .Red:
            model.rgbModel.value.r = val
            UserData().redRGBValue = val
        case .Green:
            model.rgbModel.value.g = val
            UserData().greenRGBValue = val
        case .Blue:
            model.rgbModel.value.b = val
            UserData().blueRGBValue = val
        case .Hue:
            model.hslModel.value.h = val
        case .Saturation:
            model.hslModel.value.s = val
        case .Lightness:
            model.hslModel.value.l = val
        default:
            print("Nuttin")
        }
        delegate?.didPick(color: selectedColor)
    }
    
    public func sendDataRequest() {
        if model.isScheme {
            sendSchemeRequest()
        } else {
            sendColorRequest()
        }
    }
    
    public func sendColorRequest() {
        if searchPicker == .Rgb {
            requestColor(from: RgbRequestData(value: model.rgbModel))
        } else if searchPicker == .Hsl {
            requestColor(from: HslRequestData(value: model.hslModel))
        } else if searchPicker == .Hex {
            requestColor(from: HexRequestData(value: model.hexModel))
            searchPicker = viewCategory
        }
    }
    
    public func sendSchemeRequest() {
        
    }
    
    public func cellData<T: SliderCellData>(for indexPath:IndexPath) -> T? {
        if T.self == SliderData.self {
            if viewCategory == .Rgb {
                return CellDataBuilder().getSliderCell(forRow: indexPath.row, model: model.rgbModel) as? T
            } else if viewCategory == .Hsl {
                return CellDataBuilder().getSliderCell(forRow: indexPath.row, model: model.hslModel) as? T
            }
        } else {
            // Slider Cell Data wth Select ??
        }
        return nil
    }
    
    private func requestColor<T: WSRequestData>(from data: T) {
        WebService().getColorFrom(data: data, completion: { model, error in
            if model != nil {
                self.delegate?.show(color: model!)
            } else {
                self.delegate?.show(error: error)
            }
        })
    }
    
    private func requestScheme<T: WSRequestData>(from data: T, parameters: Dictionary<String, String>) {
        WebService().getColorScheme(data: data, completion: { scheme, error in
            if scheme != nil {
                print("O **** DZIAŁA")
            } else if error != nil {
                print("O ku** ch** :(")
            }
        })
    }
     
    @objc public func rgbPicked() {
        viewCategory = .Rgb
        searchPicker = .Rgb
        delegate?.didPick(color: selectedColor)
        delegate?.reloadData()
    }

    @objc public func cmykPicked() {
        
    }
    
    @objc public func hslPicked() {
        viewCategory = .Hsl
        searchPicker = .Hsl
        delegate?.reloadData()
        delegate?.didPick(color: selectedColor)
    }
}

protocol PickerViewModelDelegate {
    func didPick(color: UIColor)
    func show(color: WSColorModel)
    func show(error: Error?)
    func reloadData()
}

enum PickerCategory: String {
    case Rgb = "RgbPickerViewCategory"
    case Cmyk = "CmykPickerViewCategory"
    case Hsl = "HslPickerViewCategory"
    case Hex = "HexPickerViewCategory"
}
