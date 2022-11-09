//
//  ModelDetailStatisticView.swift
//  Quiz Game
//
//  Created by APPLE on 10.09.2022.
//

import Foundation
import UIKit

struct ModelDetailStatisticView {
    
    let onBackButton: (()->())?
    
}

struct ModelDetailHeaderStatistic {
    
    let header = "Detailed game statistics"
    
    let help: Int16
    
    let numberOfQuestions: Int
    
    let correctAnswers: Int
}

struct ModelDetailStatisticCell {
    
    let onAction: (()->())?
    
    let textQuestion: String
    
    let myAnswer: String
    
    let isAnswer: Bool
    
    let photoQuestion: UIImage?
    
    let correctAnswer = "Correct answer"
}

struct ModelDetailStatisticSecondHeader {
    
    let header = "Details game"
}
