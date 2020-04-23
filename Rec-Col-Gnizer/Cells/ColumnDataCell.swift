//
//  ColumnDataCell.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 11/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class ColumnDataCell: UITableViewCell {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var containerHeight: CGFloat {
        return heightConstraint.constant
    }
    
    func setup<T:ColorTypeModel>(model: T, contrast: UIColor) {
        
        label.textColor = contrast
        label.text = model.typeName
        backgroundColor = .clear
        stackView.backgroundColor = .clear
        
        var columnts: [UIView] = []
        if let cmyk  = model as? CmykModel {
            let cmykval = cmyk.value.
        } else if let hsl = model as? HslModel {
            
        } else if let rgb = model as? RgbModel {
            
        }
    }
    
//    func setup(data: RgbModel, contrast: UIColor) {
//
//        label.textColor = contrast
//        label.text = "RGB"
//        backgroundColor = .clear
//        stackView.backgroundColor = .clear
//
//        let rFraction: CGFloat = 0//CGFloat(data.fraction?.r ?? 0)
//        let gFraction: CGFloat = 0//CGFloat(data.fraction?.g ?? 0)
//        let bFraction: CGFloat = 0//CGFloat(data.fraction?.b ?? 0)
//
//        let rColor = UIColor.red
//        let gColor = UIColor.green
//        let bColor = UIColor.blue
//
//        let rColumn = ColumnBuilder.createColumn(title: "\(data.value.r)\nRed",
//            fraction: rFraction, columnColor: rColor, contrast: contrast, width: 55, height: heightConstraint.constant)
//        let gColumn = ColumnBuilder.createColumn(title: "\(data.value.g)\nGreen",
//            fraction: gFraction, columnColor: gColor, contrast: contrast, width: 55, height: heightConstraint.constant)
//        let bColumn = ColumnBuilder.createColumn(title: "\(data.value.b)\nBlue",
//            fraction: bFraction, columnColor: bColor, contrast: contrast, width: 55, height: heightConstraint.constant)
//
//        stackView.insertArrangedSubview(rColumn, at: 0)
//        stackView.insertArrangedSubview(gColumn, at: 1)
//        stackView.insertArrangedSubview(bColumn, at: 2)
//    }
//
//    func setup(data: CmykModel, contrast: UIColor) {
//
//        label.textColor = contrast
//        label.text = "CMYK"
//        backgroundColor = .clear
//        stackView.backgroundColor = .clear
//
//        let cFraction: CGFloat = 0//CGFloat(data.fraction?.c ?? 0)
//        let mFraction: CGFloat = 0//CGFloat(data.fraction?.m ?? 0)
//        let yFraction: CGFloat = 0//CGFloat(data.fraction?.y ?? 0)
//        let kFraction: CGFloat = 0//CGFloat(data.fraction?.k ?? 0)
//
//        let cColor = UIColor.cyan
//        let mColor = UIColor.magenta
//        let yColor = UIColor.yellow
//        let kColor = UIColor.black
//
//        let cColumn = ColumnBuilder.createColumn(title: "\(data.value.c)\nCyan",
//            fraction: cFraction, columnColor: cColor, contrast: contrast, width: 35, height: heightConstraint.constant)
//
//        let mColumn = ColumnBuilder.createColumn(title: "\(data.value.m)\nMagenta",
//            fraction: mFraction, columnColor: mColor, contrast: contrast, width: 35, height: heightConstraint.constant)
//
//        let yColumn = ColumnBuilder.createColumn(title: "\(data.value.y)\nYellow",
//            fraction: yFraction, columnColor: yColor, contrast: contrast, width: 35, height: heightConstraint.constant)
//
//        let kColumn = ColumnBuilder.createColumn(title: "\(data.value.k)\nKey",
//            fraction: kFraction, columnColor: kColor, contrast: contrast, width: 35, height: heightConstraint.constant)
//
//        stackView.addArrangedSubview(cColumn)
//        stackView.addArrangedSubview(mColumn)
//        stackView.addArrangedSubview(yColumn)
//        stackView.addArrangedSubview(kColumn)
//    }
}

class ColumnBuilder {
    
    static func createColumn(title: String, fraction: CGFloat, columnColor: UIColor,
                             contrast: UIColor, width: CGFloat, height: CGFloat, animate: Bool = false) -> UIView {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        view.backgroundColor = .clear
        
        let labelHeight: CGFloat = 45
        let columnWidth:CGFloat = 20
        let columnHeight: CGFloat = height - labelHeight
        
        let columnBackground = UIView(frame: CGRect(x: width/2 - columnWidth/2,
                                                    y: 0,
                                                    width: width,
                                                    height: columnHeight))
        columnBackground.alpha = 0.3
        columnBackground.backgroundColor = contrast
        
        let column = UIView(frame: CGRect(x: width/2 - columnWidth/2,
                                          y: columnHeight - (columnHeight * fraction),
                                          width: width,
                                          height: columnHeight * fraction))
        column.backgroundColor = columnColor
        
        let label = UILabel(frame: CGRect(x: 0, y: columnHeight, width: width, height: labelHeight))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = contrast
        label.text = title
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        
        view.addSubview(label)
        view.addSubview(columnBackground)
        view.addSubview(column)
        
        return view
    }
}

extension UIColor {
    func isColorBlack() -> Bool {
        let colorToCheck = CIColor(color: self)
        if colorToCheck.red != 0 { return false }
        if colorToCheck.green != 0 { return false }
        if colorToCheck.blue != 0 { return false }
        return true
    }
}
