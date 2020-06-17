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
    @IBOutlet weak var nameLabel: UILabel!
    
    static let height: CGFloat = 90
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = Style.cornerRadiusSmall
        nameLabel.font = Style.fontLight
        nameLabel.textColor = Style.keyColor
    }
    
    public func setup(name: String, hex: String, color: UIColor) {
        nameLabel.text = [hex, name].joined(separator: " ")
        colorView.backgroundColor = color
    }
}
