//
//  ColorCell.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class ColorCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var additionalLabel: UILabel!
    
    static let height: CGFloat = 110
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = Style.cornerRadiusSmall
        mainLabel.font = Style.fontNormalBold
        mainLabel.textColor = Style.keyColor
        additionalLabel.font = Style.fontSmallLight
        additionalLabel.textColor = Style.keyColor
        selectionStyle = .none
    }
    
    public func setup(label1: String, label2: String, color: UIColor) {
        colorView.backgroundColor = color
        mainLabel.text = label1
        additionalLabel.text = label2
    }
}
