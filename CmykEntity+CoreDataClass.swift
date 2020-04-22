//
//  CmykEntity+CoreDataClass.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CmykEntity)
public class CmykEntity: NSManagedObject {
    
    init(context: NSManagedObjectContext, model: CmykModel, parent: ColorEntity) {
        let entity = NSEntityDescription.entity(forEntityName: "CmykEntity", in: context)!
        super.init(entity: entity, insertInto: context)
        cyan = model.value.c
        key = model.value.k
        magenta = model.value.m
        yellow = model.value.y
        color = parent
    }
    
    func toModel() -> CmykModel {
        return CmykModel(c: cyan, m: magenta, y: yellow, k: key)
    }
}
