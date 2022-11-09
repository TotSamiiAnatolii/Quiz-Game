//
//  QuestionViewDataSource.swift
//  Quiz Game
//
//  Created by APPLE on 27.07.2022.
//

import UIKit

protocol ContainerQuestionViewDataSource {
    
    func numberOfQuestionToShow() -> Int
    
    func containerView(createQuestionView index: Int) -> QuestionView
}
