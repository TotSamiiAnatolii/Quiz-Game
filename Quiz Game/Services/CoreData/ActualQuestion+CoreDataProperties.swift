//
//  ActualQuestion+CoreDataProperties.swift
//  Quiz Game
//
//  Created by APPLE on 24.09.2022.
//
//

import Foundation
import CoreData


extension ActualQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActualQuestion> {
        return NSFetchRequest<ActualQuestion>(entityName: "ActualQuestion")
    }

    @NSManaged public var date: Date
    @NSManaged public var isAnswered: Bool
    @NSManaged public var myAnswer: String
    @NSManaged public var question: Question
    @NSManaged public var actualQuizSession: ActualQuizSession

}

extension ActualQuestion : Identifiable {

}
