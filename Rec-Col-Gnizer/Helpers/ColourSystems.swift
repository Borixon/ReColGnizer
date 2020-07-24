//
//  ColourSystems.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 12/07/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
 
enum ColourSystems: String, CaseIterable {
    case Dulux = "Dulux Colours"
    case NCS = "Natural Colour System"
    case RALClassic = "RAL Classic"
    case RALDesign = "RAL Design"
    case RALEffec = "RAL Effect"
    
    var infoDescription: String {
        ""
    }
}
