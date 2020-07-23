//
//  SchemeCell.swift
//  Rec-Col-Gnizer
//
//  Created by administrator on 23/07/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class SchemeCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var schemeLabel: UILabel!
    @IBOutlet weak var colorStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
        schemeLabel.font = Style.fontNormalBold
        container.layer.borderWidth = 1
        container.layer.cornerRadius = Style.cornerRadiusSmall
        container.layer.masksToBounds = true
        colorStack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    func setup(title: String, colours: [UIColor], contrast: UIColor) {
        container.layer.borderColor = contrast.cgColor
        colorStack.removeArrangedSubviews()
        schemeLabel.text = title
        schemeLabel.textColor = contrast
        for colour in colours {
            let colourView = UIView()
            colourView.backgroundColor = colour
            colorStack.addArrangedSubview(colourView)
        }
    }
    
}

extension UIStackView {
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            view.removeFromSuperview()
        }
    }
}
