//
//  QuestionViewDelegate.swift
//  Quiz Game
//
//  Created by APPLE on 27.07.2022.
//

import UIKit

protocol QuestionViewDelegate {
        
    func tapButton(answer: UIButton, view: QuestionView)
}
