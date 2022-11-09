//
//  LogicForGame.swift
//  Quiz Game
//
//  Created by APPLE on 01.09.2022.
//

import UIKit

protocol LogicForGame {
    
    func userChoseAnswer(sender: UIButton, card: QuestionView)
    
    func deleteCard(rezultAnswer: Bool, answer: String)
    
    func afterNoCorrectAnswer(model: ModelSetting, rezultAnswer: Bool, myAnswer: String)
    
    func transitionAfterHelp(model: ModelSetting)
    
    func soundsGame(model: ModelSetting, sound: URL)
    
    func randomQuestion(model: ModelSetting)
}
