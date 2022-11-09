//
//  ModelMainView.swift
//  Quiz Game
//
//  Created by APPLE on 01.09.2022.
//

import Foundation

struct ModelGameView {
    
    let onBackAction: (()->())?
    
    let onHelpAction: (()->())?
    
    let progres: Float
    
    let currentQuestion: Int
    
    let countQuestion: Int
}
