//
//  ColorHelper.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

final class ColorHelper: NSObject {

    public func colorFrom(red: Float, green: Float, blue: Float) -> UIColor {
        let r = RGBModel.fraction(value: CGFloat(red))
        let g = RGBModel.fraction(value: CGFloat(green))
        let b = RGBModel.fraction(value: CGFloat(blue))
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
     
}
