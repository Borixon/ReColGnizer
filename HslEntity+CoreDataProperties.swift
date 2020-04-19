//
//  HslEntity+CoreDataProperties.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData


extension HslEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HslEntity> {
        return NSFetchRequest<HslEntity>(entityName: "HslEntity")
    }

    @NSManaged public var hue: Int16
    @NSManaged public var saturation: Int16
    @NSManaged public var lightness: Int16
    @NSManaged public var color: ColorEntity?

}
