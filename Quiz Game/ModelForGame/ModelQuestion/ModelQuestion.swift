//
//  ModelQuestion.swift
//  Quiz Game
//
//  Created by APPLE on 08.07.2022.
//

import UIKit

struct ModelQuestion {
    
    var textQuestion: String
    
    var answerCorrect: String
    
    var myAnswer = ""
    
    var answer: [String]
        
    var help: String
    
    var photoQuestion: UIImage?
    
    var isAnswer: Bool = false
}

struct ModelCategory {
    
    let name: String
    
    var categoryType: [ModelCategoryType]
}

struct ModelCategoryType {
    
    let name: String
    
    var question: [ModelQuestion]
    
    var isSelected: Bool = false
    
    var helpCount: Int = 0
}
