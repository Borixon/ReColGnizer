//
//  SliderCell.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 14/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

final class SliderCell: UITableViewCell {

    static let height: CGFloat = 75
    private var type: SliderCellType!
    public var delegate: SliderCellDelegate?
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        typeLabel.font = Style.fontNormalBold
        typeLabel.textColor = Style.keyColor
        valueLabel.font = Style.fontSmallRegular
        valueLabel.textColor = Style.keyColor
        slider.minimumTrackTintColor = Style.keyColor
        slider.maximumTrackTintColor = Style.keyHelperColor
    }

    public func setup(data: SliderCellData) {
        typeLabel.text = data.type.rawValue
        valueLabel.text = String(Int(data.value))
        slider.minimumValue = data.minValue
        slider.maximumValue = data.maxValue
        slider.value = data.value
        type = data.type
    }
    
    @IBAction func sliderValue(_ sender: UISlider) {
        valueLabel.text = String(Int(sender.value))
        delegate?.didChange(value: sender.value, type: type)
    }
}

protocol SliderCellDelegate {
    func didChange(value: Float, type: SliderCellType)
}

