//
//  MainViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class MainViewModel: NSObject {

    let manuItems = ["Manual", "Camera"]
    
    var backgroundColor: UIColor {
        return ColorRandomiezer.randomColor
    }
    
}
