//
//  ActualQuizSession+CoreDataProperties.swift
//  Quiz Game
//
//  Created by APPLE on 04.10.2022.
//
//

import Foundation
import CoreData


extension ActualQuizSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActualQuizSession> {
        return NSFetchRequest<ActualQuizSession>(entityName: "ActualQuizSession")
    }

    @NSManaged public var helpCount: Int16
    @NSManaged public var startDate: Date
    @NSManaged public var actualAnswers: NSSet?
    @NSManaged public var categoryType: CategoryType

}

// MARK: Generated accessors for actualAnswers
extension ActualQuizSession {

    @objc(addActualAnswersObject:)
    @NSManaged public func addToActualAnswers(_ value: ActualQuestion)

    @objc(removeActualAnswersObject:)
    @NSManaged public func removeFromActualAnswers(_ value: ActualQuestion)

    @objc(addActualAnswers:)
    @NSManaged public func addToActualAnswers(_ values: NSSet)

    @objc(removeActualAnswers:)
    @NSManaged public func removeFromActualAnswers(_ values: NSSet)

}

extension ActualQuizSession : Identifiable {

}

extension ActualQuizSession {
    static func make(model: CategoryType, context: NSManagedObjectContext) -> Self {
        let quizSession = Self(context: context)
        quizSession.categoryType = model
        
        return quizSession
    }
}
