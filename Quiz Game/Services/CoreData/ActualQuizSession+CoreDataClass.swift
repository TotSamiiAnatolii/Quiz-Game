//
//  ActualQuizSession+CoreDataClass.swift
//  Quiz Game
//
//  Created by APPLE on 04.10.2022.
//
//

import Foundation
import CoreData

@objc(ActualQuizSession)
public class ActualQuizSession: NSManagedObject {
    
    public var progressForGame: Float {
        
        var sumOfCorrectAnswers: Float = 0
        
        guard let actualAnswers = actualAnswers?.allObjects as? [ActualQuestion] else { return 0 }
        
        if actualAnswers.count > 0 {
            actualAnswers.forEach { answer in
                if answer.isAnswered {
                    
                    sumOfCorrectAnswers += 1
                }
            }
            return sumOfCorrectAnswers * 100 / Float(actualAnswers.count)
        } else {
            return 0
        }
    }
    
    public var correctAnswersCount: Int {
        
        var count: Int = 0
        
        guard let countIsAnswer = actualAnswers?.allObjects as? [ActualQuestion] else { return 0 }
        
        countIsAnswer.forEach { question in
            if question.isAnswered {
                count += 1
            }
        }
        return count
    }
}
