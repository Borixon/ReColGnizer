//
//  RgbEntity+CoreDataClass.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(RgbEntity)
public class RgbEntity: NSManagedObject {
    func toModel() -> RgbModel {
        return RgbModel(r: Int(self.red), g: Int(self.green), b: Int(self.blue))
    }
}
