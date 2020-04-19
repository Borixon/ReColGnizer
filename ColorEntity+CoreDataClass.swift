//
//  ColorEntity+CoreDataClass.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ColorEntity)
public class ColorEntity: NSManagedObject {
    init(context: NSManagedObjectContext, model: ColorModel) {
        let entity = NSEntityDescription.entity(forEntityName: "ColorEntity", in: context)!
        super.init(entity: entity, insertInto: context)
        
        distance = Int16(model.name.value.distance)
        exactMatch = model.name.value.exactMatch
        hex = model.hex.value
        name = model.name.value.name
        contrast = model.contrast.value

//          TODO
//          @NSManaged public var cmyk: CmykEntity?
//          @NSManaged public var derivativeColor: ColorEntity?
//          @NSManaged public var exactColor: ColorEntity?
//          @NSManaged public var rgb: RgbEntity?
//          @NSManaged public var hsl: HslEntity?
        
    }
    
    override public init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
