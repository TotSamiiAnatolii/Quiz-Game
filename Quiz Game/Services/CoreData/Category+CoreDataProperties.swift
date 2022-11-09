//
//  Category+CoreDataProperties.swift
//  Quiz Game
//
//  Created by Gregory Berngardt on 22.09.2022.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var categoryType: NSSet?

}

// MARK: Generated accessors for categoryType
extension Category {

    @objc(addCategoryTypeObject:)
    @NSManaged public func addToCategoryType(_ value: CategoryType)

    @objc(removeCategoryTypeObject:)
    @NSManaged public func removeFromCategoryType(_ value: CategoryType)

    @objc(addCategoryType:)
    @NSManaged public func addToCategoryType(_ values: NSSet)

    @objc(removeCategoryType:)
    @NSManaged public func removeFromCategoryType(_ values: NSSet)

}

extension Category : Identifiable {

}

extension Category {
    
    static func make(model: ModelCategory, context: NSManagedObjectContext) -> Self {
        let category = Self(context: context)
        category.name = model.name
        
        category.categoryType = NSSet(array: model.categoryType
            .map { CategoryType.make(model: $0, context: context) })
         
        return category
    }
}
