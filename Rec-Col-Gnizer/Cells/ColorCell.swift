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
    @IBOutlet weak var hexLabel: UILabel!
    
    static let height: CGFloat = 70
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = Style.cornerRadiusBig
        hexLabel.font = Style.fontSmallBold
        hexLabel.textColor = Style.keyColor
        nameLabel.font = Style.fontBold
        nameLabel.textColor = Style.keyColor
    }
    
    public func setup(name: String, hex: String, color: UIColor) {
        nameLabel.text = name
        hexLabel.text = hex
        colorView.backgroundColor = color
    }
}
