//
//  CmykEntity+CoreDataProperties.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData


extension CmykEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CmykEntity> {
        return NSFetchRequest<CmykEntity>(entityName: "CmykEntity")
    }

    @NSManaged public var cyan: Int16
    @NSManaged public var key: Int16
    @NSManaged public var magenta: Int16
    @NSManaged public var yellow: Int16
    @NSManaged public var color: ColorEntity?

}
