//
//  ColorRandomiezer.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 08/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import SwiftHEXColors

struct ColorRandomiezer {
    
    static let colors = [
        "#9BB7D4",
        "#C74375",
        "#BF1932",
        "#7BC4C4",
        "#E2583E",
        "#53B0AE",
        "#DECDBE",
        "#9B1B30",
        "#5A5B9F",
        "#F0C05A",
        "#45B5AA",
        "#D94F70",
        "#DD4124",
        "#009473",
        "#B163A3",
        "#955251",
        "#F7CAC9",
        "#92A8D1",
        "#88B04B",
        "#5F4B8B",
        "#FF6F61",
        "#0F4C81"]
    
    private static var randomColorString: String {
        guard let rand = colors.randomElement() else { return colors.first! }
        return rand
    }
    
    static var randomColor: UIColor {
        let randomHex = randomColorString
        if let color = UIColor(hexString: randomHex) {
            return color
        }
        return UIColor.black
    }
}
