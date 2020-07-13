//
//  FilterType.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 17/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

enum SortingType: String, CaseIterable {
    case nameAscending = "Name ascending"
    case nameDescending = "Name descending"
    case hexAscending = "Hex ascending"
    case hexDescending = "Hex descending"
    case brightnessAscending = "Brightness ascending"
    case brightnessDescending = "Brightness descending"
    
    func sort(objects: [ColorModel]) -> [ColorModel] {
        switch self {
        case .nameAscending:
            return objects.sorted(by:{ $0.name.value.name < $1.name.value.name })
        case .nameDescending:
            return objects.sorted(by:{ $0.name.value.name > $1.name.value.name })
        case .hexAscending:
            return objects.sorted(by:{ $0.hex.value < $1.hex.value })
        case .hexDescending:
            return objects.sorted(by:{ $0.hex.value > $1.hex.value })
        case .brightnessAscending:
            return objects.sorted(by:{ $0.brightness < $1.brightness })
        case .brightnessDescending:
            return objects.sorted(by:{ $0.brightness > $1.brightness })
        }
    }
}
