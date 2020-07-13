//
//  CoreDataStack.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import CoreData
import UIKit

protocol CoreDataStackManager {
    func contextHasChanged()
}

final class CoreDataStack: NSObject {
    
    private var privateContext: NSManagedObjectContext?
    public var manager: CoreDataStackManager?
    
    override init() {
        super.init()
        privateContext = persistentContainer.newBackgroundContext()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contexHasChanged),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: privateContext)
    }
    
    // TODO: implement more sophisticated way to inform about context changes
    @objc func contexHasChanged() {
        manager?.contextHasChanged()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecColGnizer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func getColor(forHex hex: String, completion: @escaping (ColorEntity?) -> ()) {
        let predicate = NSPredicate(format: "hex = %@", hex)
        let entity: ColorEntity? = getEntity(predicate: predicate)?.first
        completion(entity)
    }
    
    // TODO: To remove
    public func getColorsStrings(completion: @escaping ([(String, String)]?) -> ()) {
        if let data: [ColorEntity] = getEntity(predicate: nil) {
            let mapped = data.map({ return ($0.name, $0.hex) })
            completion(mapped)
        } else {
            completion(nil)
        }
    }
    
    public func getColors(completion: @escaping ([ColorModel]?) -> ()) {
        if let data: [ColorEntity] = getEntity(predicate: nil) {
            let mapped = data.map({ return ColorModel(color: $0) })
            completion(mapped)
        } else {
            completion(nil)
        }
    }
    
    public func saveColor(_ model: ColorModel) {
        guard let context = privateContext else { return }
        getColor(forHex: model.hex.value, completion: { color in
            guard color == nil else { return }
            let entity = ColorEntity(context: context, model: model)
            context.insert(entity)
            self.savePrivateContext()
        })
    }
    
    public func removeColor(_ hex: String) {
        guard let context = privateContext else { return }
        getColor(forHex: hex, completion: { color in
            guard let colorToRemove = color else { return }
            context.delete(colorToRemove)
            self.savePrivateContext()
        })
    }
    
    private func getEntieties<T: NSManagedObject>(completion: @escaping ([T]?) -> ()){
        let fetchRequest = NSFetchRequest<T>(entityName: entityName(forObject: T.self))
        do {
            if let data = try privateContext?.fetch(fetchRequest) {
                completion(data)
            }
        } catch {
            print(error)
        }
        completion(nil)
    }
    
    private func getEntity<T: NSManagedObject>(predicate: NSPredicate?) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName(forObject: T.self))
        fetchRequest.predicate = predicate
        do {
            let data = try privateContext?.fetch(fetchRequest)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
    private func entityName<T: NSManagedObject>(forObject obj: T.Type) -> String {
        switch obj {
        case is ColorEntity.Type:
            return "ColorEntity"
        default:
            return ""
        }
    }
    
    public func savePrivateContext() {
        privateContext?.perform {
            do {
                try self.privateContext?.save()
            } catch {
                // TODO: Handle
            }
        }
    }
}

