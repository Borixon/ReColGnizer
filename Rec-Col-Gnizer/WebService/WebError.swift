//
//  WebError.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
 
enum WebError: String, Error {
    case BadUrl = "App could not create color request. Contact developer"
    case NoDataForColor = "Sorry, we could not find color for given parameters"
    case NoConnection = "Sorry, we could not reach the service. Check your internet connection and try again"
}
