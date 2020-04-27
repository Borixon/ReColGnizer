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
