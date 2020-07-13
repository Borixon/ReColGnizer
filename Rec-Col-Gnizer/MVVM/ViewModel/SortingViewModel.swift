//
//  SortingViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

struct SortingViewModel {

    let cellIdentifier = "SortingCellIdentifier"
    let sortingTypes: [SortingType] = SortingType.allCases
    var selectedSortingType: SortingType? = nil
    
    var numberOfElements: Int {
        return sortingTypes.count
    }
    
    func isSelectedIndex(index: Int) -> Bool {
        guard let type = selectedSortingType else { return false }
        if sortingTypes.firstIndex(of: type) == index {
            return true
        }
        return false 
    }
    
    func elementFor(index: Int) -> SortingType? {
        guard index < sortingTypes.count else { return nil }
        return sortingTypes[index]
    }
}
