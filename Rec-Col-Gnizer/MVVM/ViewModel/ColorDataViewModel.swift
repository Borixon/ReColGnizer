//
//  ColorDataViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 11/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import SwiftHEXColors

protocol ColorDataViewModelDelegate {
    func setButtonTitle(_ title: String)
}

class ColorDataViewModel: NSObject {
    
    public let numberOfSections: Int = 3
    public let model: ColorModel
    public let schemeCellIndentifier = "SchemeCellNameIdentifier"
    public let nameCellIndentifier = "ColorCellNameIdentifier"
    public let columnDataCellIdentifier = "columnDataCellIdentifier"
    private let addToFav: String = "Add to favorite"
    private let removeFromFav: String = "Remove from favorite"
    private let columnBuilder: ColumnBuilder
    
    public var delegate: ColorDataViewModelDelegate? = nil {
        didSet {
            self.checkForButtonLabel()
        }
    }
    
    init(model: ColorModel) {
        self.model = model
        self.columnBuilder = ColumnBuilder(contrast: UIColor(hexString: model.contrast.value) ?? .black)
    }
    
    var contrastColor: UIColor {
        return UIColor(hexString: model.contrast.value) ?? .black
    }
    
    var color: UIColor {
        return UIColor(hexString: model.hex.value) ?? .white
    }
    
    var closestDefinedColor: UIColor? {
        if model.name.value.exactMatch {
            return UIColor(hexString: model.hex.value) ?? .white
        } else {
            if let closestHex = model.name.value.closestNamedHex {
                return UIColor(hexString: closestHex)
            }
            return nil
        }
    }
    
    func numberOfRows(for section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        } else {
            return 4
        }
    }
    
    var nameData: (name: String, hex: String) {
        return (model.name.value.name, model.hex.value)
    }
    
    public func schemeData(forIndex index: Int) -> (title: String, colour: [UIColor]) {
        let helper = ColorHelper()
        if index == 0 {
            let data = helper.analogous(model.hsl)
            return ("Analogous", data.map({ $0.color }))
        } else if index == 1 {
            let data = helper.complementary(model.hsl)
            return ("Complementary", data.map({ $0.color }))
        } else if index == 2 {
            let data = helper.triads(model.hsl)
            return ("Triads", data.map({ $0.color }))
        } else {
            let data = helper.splitComplementary(model.hsl, split: 15)
            return ("Split Complementary", data.map({ $0.color }))
        }
    }
    
    public func colorData(forIndex indexPath: IndexPath) -> (name: String, columns: [UIView]) {
        if indexPath.row == 0 {
            let columns = columnBuilder.getColumns(data: model.cmyk.columnData!, orderedKeys: model.cmyk.components)
            return (name: model.cmyk.typeName, columns: columns)
        } else if indexPath.row == 1 {
            let columns = columnBuilder.getColumns(data: model.rgb.columnData!, orderedKeys: model.rgb.components)
            return (name: model.rgb.typeName, columns: columns)
        } else {
            let columns = columnBuilder.getColumns(data: model.hsl.columnData!, orderedKeys: model.hsl.components)
            return (name: model.hsl.typeName, columns: columns)
        }
    }
    
    private func checkForButtonLabel() {
        DataManager.shared.isColorSaved(model.hex.value, completion: { saved in
            if saved {
                self.delegate?.setButtonTitle(self.removeFromFav)
            } else {
                self.delegate?.setButtonTitle(self.addToFav)
            }
        })
    }
    
    public func saveRemovePressed() {
        DataManager.shared.isColorSaved(model.hex.value, completion: { saved in
            if saved {
                DataManager.shared.removeColor(self.model.hex.value)
                self.delegate?.setButtonTitle(self.addToFav)
            } else {
                DataManager.shared.saveColor(self.model)
                self.delegate?.setButtonTitle(self.removeFromFav)
            }
        })
    }
}
