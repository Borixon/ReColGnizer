//
//  LibrariesViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 12/07/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

class LibrariesViewModel {
    
    var colorLibraries: [String] {
        ColourSystems.allCases.map({ return $0.rawValue })
    }
    
    var numberOfItems: Int {
        colorLibraries.count
    }
    
    
}
