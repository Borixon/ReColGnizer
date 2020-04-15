//
//  Endpoints.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 15/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
 
struct API {
    
    // Standard params
    private let domain: String = "http://thecolorapi.com"
    private let jsonFormat = "&format=json"
    private let method = "GET"
    private let headers = ["Content-Type":"application/json"]
    
    // Endpoints
    private let colorEndpoint: String = "/id?"
    private let schemeEndpoint: String = "/scheme?"
    
    // Additional params
    private let rgbParameter: String = "rgb=%@"
    private let cmykParameter: String = "cmyk=%@"
    private let hslParameter: String = "hsl=%@"
    private let hexParameter: String = "hex=%@"
    private let modeParameter: String = "mode=%@"
    private let countParamter: String = "count=%@"
    
    private func getRequest(from string: String) throws -> URLRequest {
        guard let url = URL(string: string) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method
        
        return request
    }
    
    public func colorRequest<T: WSColorData>(_ data: T) throws -> URLRequest {
        var requestString = domain + colorEndpoint
        if let hexData = data.value as? Hex {
            requestString.append(String(format: hexParameter, arguments: ["(\(hexData.value)"]))
        } else if let rgbData = data.value as? RGB {
            requestString.append(String(format: rgbParameter, arguments: ["(\(rgbData.r),\(rgbData.g),\(rgbData.b))"]))
        } else if let cmykData = data.value as? CMYK {
            let argument = "(\(cmykData.c ?? 0),\(cmykData.m ?? 0),\(cmykData.y ?? 0),\(cmykData.k ?? 0)"
            requestString.append(String(format: cmykParameter, arguments: [argument]))
        } else if let hslData = data.value as? HSL {
            requestString.append(String(format: hslParameter, arguments: ["(\(hslData.h), \(hslData.s), \(hslData.l)"]))
        }
        requestString.append(jsonFormat)
        
        return try getRequest(from: requestString)
    }
    
    public func schemeRequest() {
        
    }
}

enum SchemeModeTypes: String {
    case Monochrome = "monochrome"
    case MonochromeDark = "monochrome-dark"
    case MonochromeLight = "monochrome-light"
    case Analogic = "analogic"
    case Complement = "complement"
    case AnalogicComplement = "analogic-complement"
    case Triad = "triad"
    case Quad = "quad"
}
