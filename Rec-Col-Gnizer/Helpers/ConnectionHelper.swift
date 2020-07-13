//
//  ConnectionHelper.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 27/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import Connectivity

struct ConnectionHelper {
    static let shared = ConnectionHelper()
    let connectivity = Connectivity()
    
    var status: Connectivity.Status {
        return connectivity.status
    }
    
    init() {
        
    }
    
    public func startMonitoring() {
        connectivity.startNotifier()
    }
    
    public func stopMonitoring() {
        connectivity.stopNotifier()
    }
}
