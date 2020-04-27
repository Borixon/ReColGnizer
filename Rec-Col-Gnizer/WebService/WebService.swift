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

    public func getColorFrom<T: WSRequestData>(data: T, completion: @escaping (WSColorModel?, Error?) -> ()) {
        let urlRequest: URLRequest
        do {
            urlRequest = try getRequest(data: data)
        } catch {
            completion(nil, error)
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                do { 
                    let color = try JSONDecoder().decode(WSColorModel.self, from: data)
                    completion(color, nil)
                } catch {
                    completion(nil, error)
                }
            }
            completion(nil, nil)
        }.resume()
    }
    
    public func getColorScheme<T: WSRequestData>(data: T, completion: @escaping (WSColorSchemeModel?, Error?) -> ()) {
        let urlRequest: URLRequest
        do {
            urlRequest = try getRequest(data: data)
        } catch {
            completion(nil, error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                do {
                    let color = try JSONDecoder().decode(WSColorSchemeModel.self, from: data)
                    completion(color, nil)
                } catch {
                    completion(nil, error)
                }
            }
            completion(nil, nil)
        }.resume()
    }
    
    private func getRequest<T:WSRequestData>(data: T) throws -> URLRequest {
        do {
            try isConnectedToInternet()
            let urlRequest: URLRequest
//            if data.self {
                urlRequest = try API().colorRequest(data)
//            } else {
//                urlRequest = try API().schemeRequest(data)
//            }
            return urlRequest
        } catch {
            throw error
        }
    }
    
    private func isConnectedToInternet() throws {
        if ConnectionHelper.shared.status == .notConnected {
            throw WebError.NoConnection
        }
    }
}
