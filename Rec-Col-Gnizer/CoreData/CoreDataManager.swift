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
    
    public func getColorsList() -> [(name: String, hex: String)]? {
        if let colors = stack.getColors() {
            return colors
        }
        return nil
    }
    
    public func getColor(hex: String) -> ColorModel? {
        if let entity = stack.getColor(forHex: hex) {
//            let model = ColorModel(color: <#T##WSColorModel#>)
        }
        return nil
    }
    
    public func saveColor(_ color: ColorModel) {
        // TODO premyslec
        let context = stack.getPrivateContext()
        let entity = ColorEntity(context: context, model: color)
        context.insert(entity)
        do {
            try context.save()
        } catch {
            print(error)
        }
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
