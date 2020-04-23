//
//  StyleHelper.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 22/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

struct Style {
    
    // MARK: Corners
    static let cornerRadiusBig:CGFloat = 15
    static let cornerRadiusSmall:CGFloat = 9
    
    // MARK: Colors
    static let keyColor: UIColor = .darkGray
    static let keyHelperColor: UIColor = .lightGray
    static let keyContrastColor: UIColor = .white
    static let accentColor: UIColor = UIColor(displayP3Red: 201/255, green: 126/266, blue: 126/266, alpha: 1)
    static let accentKeyColor: UIColor = UIColor(displayP3Red: 202/255, green: 91/266, blue: 91/266, alpha: 1)
    
    // MARK: Fonts
    private static let fontSizeSmall: CGFloat = 15
    private static let fontSizeRegular: CGFloat = 17
    private static let fontSizeBig: CGFloat = 20
    private static let fontSizeXXL: CGFloat = 25
    
    private static let fontFamilyLight: String =  "Helvetica-Thin"
    private static let fontFamilyRegular: String =  "Helvetica"
    private static let fontFamilyBold: String =  "Helvetica-Bold"
    
    static let fontSmallLight: UIFont = UIFont(name: fontFamilyLight, size: fontSizeSmall)!
    static let fontSmallRegular: UIFont = UIFont(name: fontFamilyRegular, size: fontSizeSmall)!
    static let fontSmallBold: UIFont = UIFont(name: fontFamilyBold, size: fontSizeSmall)!
    
    static let fontLight: UIFont = UIFont(name: fontFamilyLight, size: fontSizeRegular)!
    static let fontRegular: UIFont = UIFont(name: fontFamilyRegular, size: fontSizeRegular)!
    static let fontBold: UIFont = UIFont(name: fontFamilyBold, size: fontSizeRegular)!
    
    static let fontBigLight: UIFont = UIFont(name: fontFamilyLight, size: fontSizeBig)!
    static let fontBigRegular: UIFont = UIFont(name: fontFamilyRegular, size: fontSizeBig)!
    static let fontBigBold: UIFont = UIFont(name: fontFamilyBold, size: fontSizeBig)!
    
}
