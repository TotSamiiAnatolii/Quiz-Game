//
//  ModelDetailSetting.swift
//  Quiz Game
//
//  Created by APPLE on 13.09.2022.
//

import Foundation

struct ModelAfterHelp {
    
    var afterHelp: ModelSettingGame
    
    var sounds: Bool
}

struct ModelDetailSetting: Codable {
    
    var nameRezult: String
    
    var isSelected: Bool = false
}

struct ModelSettingGame: Codable {
    
    let name: String
    
    var state: Bool
    
    let header: String
    
    var description: String
    
    var selectedState: [ModelDetailSetting]
}
