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
        cmyk = CmykEntity(context: context, model: model.cmyk, parent: self)
        rgb = RgbEntity(context: context, model: model.rgb, parent: self)
        hsl = HslEntity(context: context, model: model.hsl, parent: self)
        
        if let derivedColor = model.derivedColor {
            // self.derivedColor = nil
        }
        
        if let exactColor = model.exactColor {
            // self.exactColor = nil
        }
        
    }
    
    override public init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
