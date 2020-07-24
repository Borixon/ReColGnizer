//
//  CoreDataManager.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

protocol CoreDataManagerDelegate {
    func dataHasChanged()
}

class CoreDataManager {

    static let shared = CoreDataManager()
    public var delegate: CoreDataManagerDelegate?
    private let stack: CoreDataStack
    
    init() {
        stack = CoreDataStack()
        stack.manager = self
    }
    
    public func getColorsList(completion: @escaping ([ColorModel]?) -> ()) {
        stack.getColors(completion: { model in
            completion(model)
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
        stack.saveContext()
    }
    
    deinit {
        saveContext()
    }
}

extension CoreDataManager: CoreDataStackManager {
    func contextHasChanged() {
        DispatchQueue.main.async {
            self.delegate?.dataHasChanged()
        }
    }
}
