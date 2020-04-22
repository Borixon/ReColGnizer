//
//  ColorEntity+CoreDataProperties.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData


extension ColorEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ColorEntity> {
        return NSFetchRequest<ColorEntity>(entityName: "ColorEntity")
    }

    @NSManaged public var distance: Int16
    @NSManaged public var exactMatch: Bool
    @NSManaged public var hex: String
    @NSManaged public var name: String
    @NSManaged public var contrast: String
    @NSManaged public var cmyk: CmykEntity?
    @NSManaged public var derivedColor: ColorEntity?
    @NSManaged public var exactColor: ColorEntity?
    @NSManaged public var rgb: RgbEntity?
    @NSManaged public var hsl: HslEntity?

}
