//
//  PickerViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 14/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit

final class SliderPickerViewModel {
    
    let sliderCellIdentifier = "sliderCellIdentifier"
    let placeholder = "AC12F3, f3c"
    let nibName = "SliderCell"
    let segmentedItems: [String] = [PickerCategory.Rgb.rawValue, PickerCategory.Hsl.rawValue]
    var searchPicker: PickerCategory = UserData().selectedPickerCategory
    var delegate: PickerViewModelDelegate?
    private var controller: BaseViewController? = nil
    private var model: PickerColourModel = PickerColourModel()
    
    // MARK: Vars
    
    var viewCategory: PickerCategory {
        get {
            return UserData().selectedPickerCategory
        }
        set {
            UserData().selectedPickerCategory = newValue
        }
    }
    
    var numberOfRows: Int {
        return viewCategory.numberOfComponents
    }
    
    var indexOfSelectedPicker: Int {
        let picker = UserData().selectedPickerCategory
        let index = segmentedItems.firstIndex(of: picker.rawValue) ?? 0
        return index
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
    
    // MARK: Public functions
    
    public func search(hex: String) {
        guard ColorHelper.isHexValid(hex: hex) else {
            controller?.coordinator?.showAlert(title: ColorHelper.invalidHexValueTitle,
                                               message: ColorHelper.invalidHexValueInfo)
            return
        }
        model.hexModel = HexModel(value: hex)
        searchPicker = .Hex
        sendDataRequest()
    }
    
    public func setController(_ controller: BaseViewController) {
        self.controller = controller
    }
    
    public func sliderDataChange(_ value: Float, type: SliderCellType) {
        let val = Int16(value)
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
            UserData().hue = val
        case .Saturation:
            model.hslModel.value.s = val
            UserData().saturation = val
        case .Lightness:
            model.hslModel.value.l = val
            UserData().lightness = val
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
    
    public func segmentSelected(index: Int) {
        let typeString = segmentedItems[index]
        guard let type = PickerCategory(rawValue: typeString) else { return }
        switch type {
        case .Rgb:
            rgbPicked()
        case .Hsl:
            hslPicked()
        case .Cmyk:
            cmykPicked()
        case .Hex:
            let _ = 0
        }
    }
    
    // MARK: Private functions
    
    public func cellData<T: SliderCellData>(for indexPath:IndexPath) -> T? {
        guard T.self == SliderData.self else { return nil }
        if viewCategory == .Rgb {
            return CellDataBuilder().getSliderCell(forRow: indexPath.row, model: model.rgbModel) as? T
        } else if viewCategory == .Hsl {
            return CellDataBuilder().getSliderCell(forRow: indexPath.row, model: model.hslModel) as? T
        } else {
            return nil
        }
    }
    
    private func convertModelTo(_ category: PickerCategory) {
        if viewCategory == .Rgb && category == .Hsl {
            model.hslModel = model.rgbModel.toHsl()
        } else if viewCategory == .Hsl && category == .Rgb {
            model.rgbModel = model.hslModel.toRgb()
        }
        viewCategory = category
        searchPicker = category
    }
    
    private func requestColor<T: WSRequestData>(from data: T) {
        WebService().getColorFrom(data: data).done { model in
            self.delegate?.show(color: ColorModel(color: model), error: nil)
        } .catch { error in
            self.delegate?.show(color: nil, error: error)
        }
    }
    
    private func requestScheme<T: WSRequestData>(from data: T, parameters: Dictionary<String, String>) {
       
    }
     
    private func rgbPicked() {
        convertModelTo(.Rgb)
        delegate?.didPick(color: selectedColor)
        delegate?.reloadData()
    }

    private func cmykPicked() {
        // TODO
    }
    
    private func hslPicked() {
        convertModelTo(.Hsl)
        delegate?.didPick(color: selectedColor)
        delegate?.reloadData()
    }
}

protocol PickerViewModelDelegate {
    func didPick(color: UIColor)
    func show(color: ColorModel?, error: Error?)
    func reloadData()
}

enum PickerCategory: String {
    case Rgb = "RGB"
    case Cmyk = "CMYK"
    case Hsl = "HSL"
    case Hex = "HEX"
    
    var numberOfComponents: Int {
        switch self {
        case .Rgb:
            return 3
        case .Cmyk:
            return 4
        case .Hsl:
            return 3
        case .Hex:
            return 0
        }
    }
}
