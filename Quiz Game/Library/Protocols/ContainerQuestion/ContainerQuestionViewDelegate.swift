//
//  ContainerQuestionViewDelegate.swift
//  Quiz Game
//
//  Created by APPLE on 04.08.2022.
//

import UIKit

protocol ContainerQuestionViewDelegate {
    
    func questionCounting(correctAnswer: Bool)

    func containerView(answer: UIButton, view: QuestionView)
}
