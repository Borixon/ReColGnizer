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
    
    // Mode Parameter
    private let modeParameter: String = "mode=%@"
    private let countParamter: String = "count=%@"
    
    private func getRequest(from string: String) throws -> URLRequest {
        let strWithJson = string.appending(jsonFormat)
        guard let url = URL(string: strWithJson) else { throw URLError(.badURL) }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method
        
        return request
    }
    
    public func colorRequest<T: WSRequestData>(_ data: T) throws -> URLRequest {
        var requestString = domain + colorEndpoint
        
        if let hexData = data.value as? HexModel {
            requestString.append(String(format: hexParameter, arguments: ["\(hexData.value)"]))
        } else if let rgbData = data.value as? RgbModel {
            let param = "(\(rgbData.value.r),\(rgbData.value.g),\(rgbData.value.b))"
            requestString.append(String(format: rgbParameter, arguments: [param]))
        } else if let hslData = data.value as? HslModel {
            let param = "hsl(\(hslData.value.h),\(hslData.value.s),\(hslData.value.l))"
            requestString.append(String(format: hslParameter, arguments: [param]))
        }
//        } else if let cmykData = data.value as? CmykModel {
//            let argument = "(\(cmykData.c ?? 0),\(cmykData.m ?? 0),\(cmykData.y ?? 0),\(cmykData.k ?? 0)"
//            requestString.append(String(format: cmykParameter, arguments: [argument]))

        
        return try getRequest(from: requestString)
    }
    
    public func schemeRequest<T: WSRequestData>(_ data: T) throws -> URLRequest {
        var requestString = domain + schemeEndpoint
        
        if let hexData = data.value as? WSHexModel {
            requestString.append(String(format: hexParameter, arguments: ["\(hexData.value)"]))
        } else if let rgbData = data.value as? WSRgbModel {
            requestString.append(String(format: rgbParameter, arguments: ["(\(rgbData.r),\(rgbData.g),\(rgbData.b))"]))
        }
        
        requestString.append(String(format: "&" + modeParameter, SchemeModeTypes.Complement.rawValue))
        requestString.append(String(format: "&" + countParamter, "6"))
        
        return try getRequest(from: requestString)
    }
    
    // TODO oczywiscie zmiana
//    private func dupa() {
//        switch data {
//        case is HexRequestData:
//            print("HEX")
//        default:
//            print("B")
//        }
//    }
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
