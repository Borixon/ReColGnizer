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

    public func getColorFrom<T: WSRequestData>(data: T) -> Promise<WSColorModel> {
        return Promise { seal in
            createRequest(data: data).then { request in
                URLSession.shared.dataTask(.promise, with: request)
            } .done { response in
                let model = try JSONDecoder().decode(WSColorModel.self, from: response.data)
                seal.fulfill(model)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    public func getColorScheme<T: WSRequestData>(data: T, completion: @escaping (WSColorSchemeModel?, Error?) -> ()) {

    }
    
    private func isConnectedToInternet() -> Bool {
        if ConnectionHelper.shared.status == .notConnected {
            return false
        }
        return true
    }
    
    private func createRequest<T:WSRequestData>(data:T) -> Promise<URLRequest> {
        return Promise { seal in
            do {
                let urlRequest: URLRequest
                urlRequest = try API().colorRequest(data)
                seal.fulfill(urlRequest)
            } catch {
                seal.reject(error)
            }
        }
    }
}
