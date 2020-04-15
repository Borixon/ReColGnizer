//
//  WSColorData.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 15/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

protocol WSColorData {
    associatedtype Data
    var value: Data { get set }
}

struct HexRequestData: WSColorData {
    typealias Data = Hex
    var value: Hex
}

struct RGBRequestData: WSColorData {
    typealias Data = RGB
    var value: RGB
}

struct CMYKRequestData: WSColorData {
    typealias Data = CMYK
    var value: CMYK
}

struct HSLRequestData: WSColorData {
    typealias Data = HSL
    var value: HSL
}

class WSAnyColorData<T>: WSColorData {
    typealias Data = T
    var value: Data
    
    init<U: WSColorData>(_ data: U) where U.Data == T {
        value = data.value
    }
    
    func getMe() {
        
    }
}
