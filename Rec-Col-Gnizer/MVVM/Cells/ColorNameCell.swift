//
//  ColorNameCell.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 11/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class ColorNameCell: UITableViewCell {

    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(name: String, hex: String, contrast: UIColor) {
        backgroundColor = .clear
        hexLabel.text = hex
        hexLabel.textColor = contrast
        nameLabel.text = name
        nameLabel.textColor = contrast
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
