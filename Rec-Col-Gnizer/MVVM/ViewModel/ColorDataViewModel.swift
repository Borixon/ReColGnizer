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

    public let model: ColorModel
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
    
    var numberOfRows: Int {
        return 4 //TEMP
//        if model.name.value.exactMatch {
//            return 4
//        } else {
//            return 5
//        }
    }
    
    var nameData: (name: String, hex: String) {
        return (model.name.value.name, model.hex.value)
    }
    
    public func colorData(forIndex indexPath: IndexPath) -> (name: String, columns: [UIView], contrast: UIColor)? {
        if indexPath.row == 1 {
            let columns = columnBuilder.getColumns(data: model.cmyk.columnData!, orderedKeys: model.cmyk.components)
            return (name: model.cmyk.typeName, columns: columns, contrast: columnBuilder.columnColor)
        } else if indexPath.row == 2 {
            let columns = columnBuilder.getColumns(data: model.rgb.columnData!, orderedKeys: model.rgb.components)
            return (name: model.rgb.typeName, columns: columns, contrast: columnBuilder.columnColor)
        } else if indexPath.row == 3 {
            let columns = columnBuilder.getColumns(data: model.hsl.columnData!, orderedKeys: model.hsl.components)
            return (name: model.hsl.typeName, columns: columns, contrast: columnBuilder.columnColor)
        }
        return nil
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
