//
//  ModelStartView.swift
//  Quiz Game
//
//  Created by APPLE on 01.09.2022.
//

import Foundation

struct ModelMainView {
    
    let onAction: ((ButtonType)->())?
    
    let header = "Hello 👋, \nlet's play?"
    
    let buttonStartLabel = "Start"
    
    let buttonStatisticsLabel = "Statistics"
        
    let category = "Current category:"
    
    let currentCategory: String
    
}
