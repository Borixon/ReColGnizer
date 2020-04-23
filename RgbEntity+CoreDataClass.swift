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
    
    init(context: NSManagedObjectContext, model: RgbModel, parent: ColorEntity) {
        let entity = NSEntityDescription.entity(forEntityName: "RgbEntity", in: context)!
        super.init(entity: entity, insertInto: context)
        red = model.value.r
        green = model.value.g
        blue = model.value.b
        color = parent
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    func toModel() -> RgbModel {
        return RgbModel(r: red, g: green, b: blue)
    }
}
