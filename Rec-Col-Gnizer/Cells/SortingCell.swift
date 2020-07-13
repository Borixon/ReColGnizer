//
//  SortingCell.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class SortingCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = Style.fontNormalLight
        label.tintColor = Style.keyColor
        checkImage.image = UIImage(named: "CheckMark")?.withRenderingMode(.alwaysTemplate)
        checkImage.tintColor = Style.accentColor
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(name: String?, selected: Bool) {
        label.text = name
        if selected {
            checkImage.isHidden = false
        } else {
            checkImage.isHidden = true
        }
    }
    
}
