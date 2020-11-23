//
//  DatabaseManager.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import Foundation
import CoreData

open class DatabaseManager{
    public static let standard = DatabaseManager()

    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return DatabaseManager.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        //The container that holds both data model entities
        let container = NSPersistentContainer(name: "Counters")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    class func saveContext() {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
                print("Data Saved to Context")
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /* Support for GRUD Operations */

    // GET / Fetch / Requests
    func getAllCounters() -> Array<CounterTb> {
        let all = NSFetchRequest<CounterTb>(entityName: "CounterTb")
        var allCounters = [CounterTb]()

        do {
            all.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            let fetched = try DatabaseManager.getContext().fetch(all)
            allCounters = fetched
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }

        return allCounters
    }
    
    // Get Counter by id
    func getCounter(fromId counnterId: String) -> CounterTb? {
        let requested = NSFetchRequest<CounterTb>(entityName: "CounterTb")
        requested.predicate = NSPredicate(format: "id == %@", counnterId)

        do {
            let fetched = try DatabaseManager.getContext().fetch(requested)

            //fetched is an array we need to convert it to a single object
            if (fetched.count > 1) {
                //TODO: handle duplicate records
            } else {
                return fetched.first //only use the first object..
            }
        } catch {
            let nserror = error as NSError
            //TODO: Handle error
            print(nserror.description)
        }

        return nil
    }
    
    // REMOVE / Delete
    func deleteCounter(forId counterId: String) -> Bool {
        let success: Bool = true

        let requested = NSFetchRequest<CounterTb>(entityName: "CounterTb")
        requested.predicate = NSPredicate(format: "id == %@", counterId)

        do {
            let fetched = try DatabaseManager.getContext().fetch(requested)
            for counter in fetched {
                DatabaseManager.getContext().delete(counter)
            }
            return success
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }
        return !success
    }
    
    // Create New Counter
    func saveListCountersToCoreData(_ counters: [CounterModel]) {
        for counter in counters{
            let entity = NSEntityDescription.entity(forEntityName: "CounterTb", in: DatabaseManager.getContext())
            let newCounter = NSManagedObject(entity: entity!, insertInto: DatabaseManager.getContext())
            newCounter.setValue(counter.id, forKey: "id")
            newCounter.setValue(counter.title, forKey: "title")
            newCounter.setValue(counter.count, forKey: "count")
            newCounter.setValue(Date(), forKey: "createdAt")
        }
    }
    
    func upDateCounter(_ counter:CounterModel) {
        guard let counterFocus = getCounter(fromId: counter.id) else{return}
        counterFocus.setValue(counter.count, forKey: "count")
        DatabaseManager.saveContext()
    }
    
    
    // Delete all Counters from CoreData
    func deleteAllCounters() {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CounterTb")
            let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)

            try DatabaseManager.getContext().execute(deleteALL)
            DatabaseManager.saveContext()
        } catch {
            print ("There is an error in deleting records")
        }
    }
}
