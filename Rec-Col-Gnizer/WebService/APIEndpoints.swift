//
//  Endpoints.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
 
struct API {
    
    private let domain: String = "http://thecolorapi.com"
    private let jsonFormat = "&format=json"
    
    private let rgbEndpoint: String = "/id?rgb="
    private let colorMethod = "GET"
    private let colorHeaders = ["Content-Type":"application/json"]
    
    public func requestColorData(_ r: Int, _ g: Int, _ b: Int) throws -> URLRequest {
        let colorParams = try getRGBParams(r: r, g: g, b: b)
        guard let url = URL(string: domain + rgbEndpoint + colorParams + jsonFormat) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = colorMethod
        request.allHTTPHeaderFields = colorHeaders
        
        return request
    }
    
    func getRGBParams(r: Int, g: Int, b: Int) throws -> String {
        if !(0...255).contains(r) { throw WebError.RValueNotAcceptable }
        if !(0...255).contains(g) { throw WebError.GValueNotAcceptable }
        if !(0...255).contains(b) { throw WebError.BValueNotAcceptable }
        return "rgb(\(r),\(g),\(b))"
    }
    
}
