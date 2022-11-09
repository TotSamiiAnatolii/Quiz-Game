//
//  CoreDataManager.swift
//  Quiz Game
//
//  Created by APPLE on 16.09.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(model: "Question")
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(model: String) {
        self.persistentContainer = NSPersistentContainer(name: model)
    }

    func firstLaunch() {
        let context = CoreDataManager.shared.viewContext
        
        let data = DataQuestionGame()
        
        data.category.forEach{Category.make(model: $0, context: context)}
        
        let categoryType = CoreDataManager.shared.receiveCategoryType()

        let categoryForGame = CategoryForGame(context: context)
        
        categoryForGame.category = categoryType[0]
        
        do {
            try context.save()
            
        } catch {
            print("[ERROR]: \(error)")
        }
        
        CoreDataManager.shared.save()
    }
    
    func receiveNotes() -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        let sortDescriptorName = NSSortDescriptor(keyPath: \Category.name, ascending: false)
        
        request.sortDescriptors = [sortDescriptorName]
        do {
            return try viewContext.fetch(request)
        } catch  {
            print(error.localizedDescription)
        }
        return []
    }
    
    func receiveCategoryType() -> [CategoryType] {
        let request: NSFetchRequest<CategoryType> = CategoryType.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \CategoryType.name, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {
            return try viewContext.fetch(request)
        } catch  {
            print(error.localizedDescription)
        }
        return []
    }

    func receiveActualQuizSession() -> [ActualQuizSession] {
        let request: NSFetchRequest<ActualQuizSession> = ActualQuizSession.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \ActualQuizSession.startDate, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {
            return try viewContext.fetch(request)
        } catch  {
            print(error.localizedDescription)
        }
        return []
    }
    
    func receiveCategorForGame() -> [CategoryForGame] {
        let request: NSFetchRequest<CategoryForGame> = CategoryForGame.fetchRequest()
     
        do {
            return try viewContext.fetch(request)
        } catch  {
            print(error.localizedDescription)
        }
        return []
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try  viewContext.save()
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteActualSession(session: ActualQuizSession) {
        viewContext.delete(session)
        save()
    }
    
    func load(complition: (()->())? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            complition?()
        }
    }
}

