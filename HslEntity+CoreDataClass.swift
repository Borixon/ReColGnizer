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
    
    init(context: NSManagedObjectContext, model: HslModel, parent: ColorEntity) {
        let entity = NSEntityDescription.entity(forEntityName: "HslEntity", in: context)!
        super.init(entity: entity, insertInto: context)
        hue = model.value.h
        saturation = model.value.s
        lightness = model.value.l
        color = parent
    }
     
    override public init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    func toModel() -> HslModel {
        return HslModel(h: hue, s: saturation, l: lightness)
    }
}
