//
//  WebService.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 08/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import PromiseKit

class WebService: NSObject {

    public func getColorFrom<T: WSColorData>(data: T, completion: @escaping (ColorModel?, Error?) -> ()) {
        let urlRequest: URLRequest
        do {
            urlRequest = try API().colorRequest(data)
        } catch {
            completion(nil, error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                do { 
                    let color = try JSONDecoder().decode(ColorModel.self, from: data)
                    completion(color, nil)
                } catch {
                    completion(nil, error)
                }
            }
            completion(nil, nil)
        }.resume()
    }
    
    public func getColorScheme() {
        
    }
    
}
