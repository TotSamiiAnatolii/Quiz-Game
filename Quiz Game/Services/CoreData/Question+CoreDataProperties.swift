//
//  Question+CoreDataProperties.swift
//  Quiz Game
//
//  Created by Gregory Berngardt on 22.09.2022.
//
//

import Foundation
import CoreData

extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var answer: [String]
    @NSManaged public var answerCorrect: String
    @NSManaged public var help: String
    @NSManaged public var isAnswer: Bool
    @NSManaged public var myAnswer: String
    @NSManaged public var photoQuestion: Data?
    @NSManaged public var textQuestion: String
    @NSManaged public var type: CategoryType?

}

extension Question : Identifiable {

}

extension Question {
    
    static func make(questionModel: ModelQuestion, context: NSManagedObjectContext) -> Self {
        let question = Self(context: context)
        question.textQuestion = questionModel.textQuestion
        question.answerCorrect = questionModel.answerCorrect
        question.myAnswer = questionModel.myAnswer
        question.answer = questionModel.answer
        question.help = questionModel.help
        question.photoQuestion = questionModel.photoQuestion?.jpegData(compressionQuality: 1.0)
        question.isAnswer = questionModel.isAnswer
        return question
    }
}
