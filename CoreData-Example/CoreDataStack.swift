//
//  CoreDataStack.swift
//  CoreData-Example
//
//  Created by Sumit Ghosh on 29/06/17.
//  Copyright © 2017 globussoft. All rights reserved.
//

import Foundation
import CoreData

func createMainContext() -> NSManagedObjectContext {
    
    //Initialize NSManagedObjectModel
    let modelURL = Bundle.main.url(forResource: "UsersData", withExtension: "momd")
    guard  let model = NSManagedObjectModel(contentsOf: modelURL!) else {fatalError("Model not found")}
    
    // Configure NSPersistanceCoordinator
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    let storeURL = URL.documentURL.appendingPathComponent("UsersData.sqlite")
    
    // Todo: migration
    try! FileManager.default.removeItem(at: storeURL)
    try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName:nil, at: storeURL, options: nil)
    
    // Create and return NSManagedObjectContext
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    return context
}

extension URL {
    static var documentURL: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}

protocol ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext! {get set}
}
