//
//  RgbEntity+CoreDataProperties.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData


extension RgbEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RgbEntity> {
        return NSFetchRequest<RgbEntity>(entityName: "RgbEntity")
    }

    @NSManaged public var blue: Int16
    @NSManaged public var green: Int16
    @NSManaged public var red: Int16
    @NSManaged public var color: ColorEntity?

}
