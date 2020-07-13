//
//  LibrariesViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 12/07/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class LibrariesViewModel {
    
    let cellIdentifier = "UITableViewCellIdentifier"
    
    var colorLibraries: [String] {
        ColourSystems.allCases.map({ return $0.rawValue })
    }
    
    var numberOfItems: Int {
        colorLibraries.count
    }
    
    var cellHeight: CGFloat {
        Style.cellHeightRegular
    }
    
    func cellForRow(index: Int, cell: inout UITableViewCell) {
        guard index < colorLibraries.count else { return }
        cell.textLabel?.text = colorLibraries[index]
        cell.textLabel?.font = Style.fontNormalLight
        cell.tintColor = Style.keyColor
        cell.selectionStyle = .none
    }
}
