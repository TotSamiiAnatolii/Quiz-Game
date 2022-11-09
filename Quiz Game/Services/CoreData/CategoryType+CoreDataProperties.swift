//
//  CategoryType+CoreDataProperties.swift
//  Quiz Game
//
//  Created by APPLE on 04.10.2022.
//
//

import Foundation
import CoreData


extension CategoryType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryType> {
        return NSFetchRequest<CategoryType>(entityName: "CategoryType")
    }

    @NSManaged public var helpCount: Int32
    @NSManaged public var isSelected: Bool
    @NSManaged public var name: String
    @NSManaged public var actualQuizSession: NSSet?
    @NSManaged public var category: Category?
    @NSManaged public var categoryForGame: CategoryForGame?
    @NSManaged public var question: NSSet

}

// MARK: Generated accessors for actualQuizSession
extension CategoryType {

    @objc(addActualQuizSessionObject:)
    @NSManaged public func addToActualQuizSession(_ value: ActualQuizSession)

    @objc(removeActualQuizSessionObject:)
    @NSManaged public func removeFromActualQuizSession(_ value: ActualQuizSession)

    @objc(addActualQuizSession:)
    @NSManaged public func addToActualQuizSession(_ values: NSSet)

    @objc(removeActualQuizSession:)
    @NSManaged public func removeFromActualQuizSession(_ values: NSSet)

}

// MARK: Generated accessors for question
extension CategoryType {

    @objc(addQuestionObject:)
    @NSManaged public func addToQuestion(_ value: Question)

    @objc(removeQuestionObject:)
    @NSManaged public func removeFromQuestion(_ value: Question)

    @objc(addQuestion:)
    @NSManaged public func addToQuestion(_ values: NSSet)

    @objc(removeQuestion:)
    @NSManaged public func removeFromQuestion(_ values: NSSet)

}

extension CategoryType : Identifiable {

}

extension CategoryType {
    static func make(model: ModelCategoryType, context: NSManagedObjectContext) -> Self {
        let categoryType = Self(context: context)
        categoryType.name = model.name
        categoryType.isSelected = false
        categoryType.question = NSSet(
            array: model.question.map { Question.make(questionModel: $0, context: context) }
        )
        return categoryType
    }
}
