//
//  HslEntity+CoreDataClass.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(HslEntity)
public class HslEntity: NSManagedObject {
    func toModel() -> HslModel {
        return HslModel(h: Int(hue), s: Int(saturation), l: Int(lightness))
    }
}
