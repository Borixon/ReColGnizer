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
    
    func setup(name: String, columns: [UIView], contrast: UIColor) {
        label.textColor = contrast
        label.text = name
        backgroundColor = .clear
        stackView.backgroundColor = .clear
        
        for arrangedView in stackView.arrangedSubviews {
            arrangedView.removeFromSuperview()
        }
        
        for column in columns {
            stackView.addArrangedSubview(column)
        }
    }
    
}

class ColumnBuilder {
    
    let columnColor: UIColor
    
    init(contrast: UIColor) {
        self.columnColor = contrast
    }
    
    func getColumns(data: [String: (val: Int16, max: Int16)], orderedKeys: [String]) -> [UIView] {
        // TODO: Some other method
        let width: CGFloat = 150 / CGFloat(data.count)
        var columns: [UIView] = []
       
        for key in orderedKeys {
            if let columnData = data[key] {
                let fraction: CGFloat = CGFloat(columnData.val) / CGFloat(columnData.max)
                columns.append(createColumn(title: key + "\n\(columnData.val)", fraction: fraction, width: width))
            }
        }
        
        return columns
    }
    
    private func createColumn(title: String, fraction: CGFloat, width: CGFloat, height: CGFloat = 140) -> UIView {
        
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
        columnBackground.backgroundColor = columnColor
        
        let column = UIView(frame: CGRect(x: width/2 - columnWidth/2,
                                          y: columnHeight - (columnHeight * fraction),
                                          width: width,
                                          height: columnHeight * fraction))
        column.backgroundColor = columnColor
        
        let label = UILabel(frame: CGRect(x: 0, y: columnHeight, width: width, height: labelHeight))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = columnColor
        label.text = title
        label.textAlignment = .center
        label.minimumScaleFactor = 0.25
        
        view.addSubview(label)
        view.addSubview(columnBackground)
        view.addSubview(column)
        
        return view
    }
    
    private func addConstraints(view: inout UIView, column: inout UIView, background: inout UIView, label: inout UIView) {
        
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
