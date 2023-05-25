//
//  DataManager.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 24/05/23.
//

import Foundation
import CoreData

class DataManager: ObservableObject {
    // Responsible for preparing a model
    let persistentContainer: NSPersistentContainer
    static let shared = DataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getResultById(id: NSManagedObjectID) -> Result? {
        
        do {
            return try viewContext.existingObject(with: id) as? Result
        } catch {
            return nil
        }
        
    }
    
    func deleteResult(result: Result) {
        viewContext.delete(result)
        save()
    }
    
    func clearAllResult() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Result")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            fatalError("\(error)")
        }
    }
        
    func getAllResults() -> [Result] {
        
        let request: NSFetchRequest<Result> = Result.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CalorieSnapCoreData")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
}
