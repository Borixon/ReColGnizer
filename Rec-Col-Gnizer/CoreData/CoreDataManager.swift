//
//  CoreDataManager.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class CoreDataManager: NSObject {

    static let shared = CoreDataManager()
    private let stack = CoreDataStack()
    
    public func getColorsList() -> [String]? {
        if let colors = stack.getColors() {
            return colors
        }
        return nil
    }
    
    public func getColor(hex: String) {
        
    }
    
    public func saveColor(_ color: ColorModel) {
        let context = stack.getPrivateContext()
        let entity = ColorEntity(context: context, model: color)
        context.insert(entity)
    }
    
    public func removeColor() {
        
    }
    
    
    public func saveContext() {
        stack.saveContext()
    }
    
    deinit {
        saveContext()
    }
}
