//
//  SliderCell.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 14/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

final class SliderCell: UITableViewCell {

    static let height: CGFloat = 80
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func setup(data: CellData) {
        typeLabel.text = data.typeName
        valueLabel.text = data.currentValue
    }
    
}

protocol CellData {
    var typeName: String { get set }
    var currentValue: String { get set }
}
