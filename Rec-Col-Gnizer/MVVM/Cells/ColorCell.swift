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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = 8
    }
    
    public func setup(name: String, hex: String, color: UIColor) {
        nameLabel.text = name
        hexLabel.text = hex
        colorView.backgroundColor = color
    }
}
