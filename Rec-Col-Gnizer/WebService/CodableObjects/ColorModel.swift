//
//  ColorModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 08/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

struct ColorModel: Codable {
    let hex: Hex
    let rgb: RGB
    let hsl: HSL
    let name: ColorName
    let contrast: ContrastColor
    let cmyk: CMYK
}

struct Hex: Codable {
    let value: String
    let clean: String
}

struct RGB: Codable {
    let r: Int
    let g: Int
    let b: Int
    let value: String
    let fraction: RGBFraction
}

struct RGBFraction: Codable {
    let r: Double
    let g: Double
    let b: Double
}

struct HSL: Codable {
    let h: Int
    let s: Int
    let l: Int
    let value: String
    let fraction: HSLFraction
}

struct HSLFraction: Codable {
    let h: Double
    let s: Double
    let l: Double
}

struct ColorName: Codable {
    let value :String
    let closest_named_hex: String
    let exact_match_name: Bool
    let distance: Int
}

struct ContrastColor: Codable {
    let value: String
}

struct CMYK: Codable {
    let c: Int?
    let m: Int?
    let y: Int?
    let k: Int?
    let value: String
    let fraction: CMYKFraction
}

struct CMYKFraction: Codable {
    let c: Double
    let m: Double
    let y: Double
    let k: Double
}
