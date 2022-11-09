//
//  ModelStatistic.swift
//  Quiz Game
//
//  Created by APPLE on 06.09.2022.
//

import Foundation

struct ModelStatistic {
    
    let settingSound: Bool
    
    var categoryType: [Category]
    
    var historyGame: [ActualQuizSession]
    
    var categoryComplMastered: Float {
        
        let countCategoryType = categoryType.count
        
        var progress: Float = 0
        
        for i in categoryType {
            
            progress += i.progressCategory
        }
        
        return progress / Float(countCategoryType)
    }
}
