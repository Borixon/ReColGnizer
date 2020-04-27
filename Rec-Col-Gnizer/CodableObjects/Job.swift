//
//  Jobs.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 26/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import Foundation

struct Jobs: Codable {
    let positions: [Job]
}

struct Job: Codable {
    let companyName: String
    let workPeriod: String
    let link: String
}
