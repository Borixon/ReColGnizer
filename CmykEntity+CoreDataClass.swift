//
//  CmykEntity+CoreDataClass.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CmykEntity)
public class CmykEntity: NSManagedObject {
    func toModel() -> CmykModel {
        return CmykModel(c: Int(cyan), m: Int(magenta), y: Int(yellow), k: Int(key))
    }
}
