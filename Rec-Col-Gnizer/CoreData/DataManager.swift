//
//  CoreDataManager.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

protocol DataManagerDelegate {
    func dataHasChanged()
}

class DataManager {

    static let shared = DataManager()
    public var delegate: DataManagerDelegate?
    private let stack: CoreDataStack
    
    init() {
        stack = CoreDataStack()
        stack.manager = self
    }
    
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
    
    public func isColorSaved(_ hex: String, completion: @escaping (Bool) -> ()) {
        stack.getColor(forHex: hex, completion: { entity in
            if entity != nil {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    public func saveColor(_ color: ColorModel) {
        stack.saveColor(color)
    }
    
    public func removeColor(_ hex: String) {
        stack.removeColor(hex)
    }
    
    public func saveContext() {
        stack.savePrivateContext()
        stack.saveContext()
    }
    
    deinit {
        saveContext()
    }
}

extension DataManager: CoreDataStackManager {
    func contextHasChanged() {
        delegate?.dataHasChanged()
    }
}
