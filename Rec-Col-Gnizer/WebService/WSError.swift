//
//  WebError.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
 
enum WebError: Error {
    case RValueNotAcceptable
    case GValueNotAcceptable
    case BValueNotAcceptable
    case NoDataForColor
}
