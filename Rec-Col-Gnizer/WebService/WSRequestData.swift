//
//  WSColorData.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 15/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

protocol WSRequestData {
    associatedtype Data
    var value: Data { get set }
}

struct HexRequestData: WSRequestData {
    typealias Data = HexModel
    var value: Data
}

struct RgbRequestData: WSRequestData {
    typealias Data = RgbModel
    var value: Data
}

struct CmykRequestData: WSRequestData {
    typealias Data = WSCmykModel
    var value: Data
}

struct HslRequestData: WSRequestData {
    typealias Data = HslModel
    var value: Data
}

