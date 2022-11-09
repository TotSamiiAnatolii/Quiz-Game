//
//  SelectViewControllerDataSourse.swift
//  Quiz Game
//
//  Created by USER on 14.08.2022.
//

import Foundation

protocol SelectViewControllerDataSourse {
    
    func featchSettingGame() -> ModelSetting
    
    func updateCurrentCategory(category: CategoryType)
    
    func updateSettingsGame(setting model: ModelSetting?)
}
