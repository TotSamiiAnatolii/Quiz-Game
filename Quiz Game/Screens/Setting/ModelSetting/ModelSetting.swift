//
//  ModelForSetting.swift
//  Quiz Game
//
//  Created by APPLE on 01.09.2022.
//

import Foundation

struct ModelSetting: Codable {
    
    var sounds: Bool
    
    var afterHelp: ModelSettingGame
    
    var transitionAfterHelp: ModelSettingGame
    
    var randomQuestion: Bool
}

