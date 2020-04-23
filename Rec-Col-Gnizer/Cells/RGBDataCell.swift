//
//  RGBDataCell.swift
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
    
    func setup(data: RGB, contrast: UIColor) {
        
        label.textColor = contrast
        label.text = "RGB"
        backgroundColor = .clear
        stackView.backgroundColor = .clear
        
        let rFraction = CGFloat(data.fraction.r)
        let gFraction = CGFloat(data.fraction.g)
        let bFraction = CGFloat(data.fraction.b)
        
        let rColor = UIColor.red
        let gColor = UIColor.green
        let bColor = UIColor.blue
        
        let rColumn = ColumnBuilder.createColumn(title: "\(data.r)\nRed",
            fraction: rFraction, columnColor: rColor, contrast: contrast, width: 55, height: heightConstraint.constant)
        let gColumn = ColumnBuilder.createColumn(title: "\(data.g)\nGreen",
            fraction: gFraction, columnColor: gColor, contrast: contrast, width: 55, height: heightConstraint.constant)
        let bColumn = ColumnBuilder.createColumn(title: "\(data.b)\nBlue",
            fraction: bFraction, columnColor: bColor, contrast: contrast, width: 55, height: heightConstraint.constant)
         
        stackView.insertArrangedSubview(rColumn, at: 0)
        stackView.insertArrangedSubview(gColumn, at: 1)
        stackView.insertArrangedSubview(bColumn, at: 2)
    }
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
        columnBackground.backgroundColor = contrast
        
        let column = UIView(frame: CGRect(x: width/2 - columnWidth/2,
                                          y: columnHeight - (columnHeight * fraction),
                                          width: width,
                                          height: columnHeight * fraction))
        column.backgroundColor = columnColor
        
        let label = UILabel(frame: CGRect(x: 0, y: columnHeight, width: width, height: labelHeight))
        label.contentMode = .center
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = contrast
        label.text = title
        label.textAlignment = .center
        
        view.addSubview(label)
        view.addSubview(columnBackground)
        view.addSubview(column)
        
        return view
    }
}
