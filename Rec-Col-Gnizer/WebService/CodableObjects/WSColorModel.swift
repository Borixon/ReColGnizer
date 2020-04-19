//
//  ColorModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 08/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

struct WSColorModel: Codable {
    let hex: WSHexModel
    let rgb: WSRgbModel
    let hsl: WSHslModel
    let name: WSColorNameModel
    let contrast: WSContrastColorModel
    let cmyk: WSCmykModel
}

struct WSHexModel: Codable {
    let value: String
    let clean: String? // what is this
}

struct WSRgbModel: Codable {
    let r: Int
    let g: Int
    let b: Int
    let value: String
    let fraction: WSRgbFraction?
}

struct WSRgbFraction: Codable {
    let r: Double
    let g: Double
    let b: Double
}

struct WSHslModel: Codable {
    let h: Int
    let s: Int
    let l: Int
    let value: String
    let fraction: WSHslFraction?
}

struct WSHslFraction: Codable {
    let h: Double
    let s: Double
    let l: Double
}

struct WSCmykModel: Codable {
    let c: Int?
    let m: Int?
    let y: Int?
    let k: Int?
    let value: String?
    let fraction: WSCmykFraction?
}

struct WSCmykFraction: Codable {
    let c: Double
    let m: Double
    let y: Double
    let k: Double
}

struct WSColorNameModel: Codable {
    let value :String
    let closest_named_hex: String
    let exact_match_name: Bool
    let distance: Int
}

struct WSContrastColorModel: Codable {
    let value: String
}
