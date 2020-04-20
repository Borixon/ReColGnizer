//
//  CoreDataManager.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    static let shared = DataManager()
    private let stack = CoreDataStack()
    
    public func getColorsList(completion: @escaping ([(name: String, hex: String)]?) -> ()) {
        stack.getColorsStrings(completion: { data in
            completion(data)
        })
    }
    
    public func getColor(hex: String, completion: @escaping (ColorModel?)->()) {
        stack.getColor(forHex: hex, completion: { entity in
            if let entityObj = entity {
                completion(ColorModel(color: entityObj))
            } else {
                completion(nil)
            }
        })
    }
    
    public func saveColor(_ color: ColorModel) {
        stack.saveColor(color)
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
