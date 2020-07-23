//
//  ImageError.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 07/05/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

enum ImageError: String, Error {
    case noCGImage = "No suitable image data to precess"
}
