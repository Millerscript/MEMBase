//
//  MEMBaseDataManager.swift
//  MCBase
//
//  Created by Miller Mosquera on 2/03/24.
//

import Foundation
import CoreData

public protocol DataManagerProtocol {
    associatedtype T
    
    var modelName: String {get set}
    var entityName: String {get set}
    
    func create(data: [String: Any]) -> T?
    func fetch(with field: String, value: String) -> T?
    func fetch() -> [T]?
    func update(entityObject: T)
    func delete(entityObject: T)
    func removeAll()
}

open class MEMBaseDataManager<T: NSManagedObject>: DataManagerProtocol {
    
    public var modelName: String
    public var entityName: String
    
    public typealias T = T
    
    // MARK: - Core Data Stack
    public lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }

        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"

        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                                  configurationName: nil,
                                                                  at: persistentStoreURL,
                                                              options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
        } catch {
            fatalError("Unable to Load Persistent Store")
        }

        return persistentStoreCoordinator
    }()
    
    public init(modelName: String, entityName: String) {
        self.modelName = modelName
        self.entityName = entityName
    }
    
    @discardableResult
    public func create(data: [String : Any]) -> T? {
        let entity = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: managedObjectContext) as! T
        
        for (key, value) in data {
            print("\(key): \(value)")
            entity.setValue(value, forKey: key)
        }

        do {
            try managedObjectContext.save()
            return entity
        } catch let error {
            print("Failed to create: \(error)")
        }
        
        return nil
    }
    
    public func fetch(with field: String, value: String) -> T? {

        let fetchRequest = NSFetchRequest<T>(entityName: self.entityName)
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "\(field) == %@", value)
        
        do {
            let user = try managedObjectContext.fetch(fetchRequest)
            return (user.count > 1) ? user.first : nil
        } catch let error {
          print("Failed to fetch: \(error)")
        }
        
        return nil
    }
    
    public func fetch() -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: self.entityName)

        do {
            let user = try managedObjectContext.fetch(fetchRequest)
            return user.count > 1 ? user : nil
        } catch let error {
          print("Failed to fetch: \(error)")
        }
        
        return nil
    }
    
    public func update(entityObject: T) {
        do {
            try managedObjectContext.save()
        } catch let error {
            print("Failed to update: \(error)")
        }
    }
    
    public func delete(entityObject: T) {
        managedObjectContext.delete(entityObject)
        
        do {
            try managedObjectContext.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }
    
    public func removeAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentStoreCoordinator.execute(deleteRequest, with: managedObjectContext)
        } catch let error {
            print("Failed to remove all: \(error)")
        }
    }
    
}

