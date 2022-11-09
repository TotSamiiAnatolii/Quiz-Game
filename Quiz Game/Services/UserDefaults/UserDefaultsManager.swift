//
//  UserDefaultsManager.swift
//  Quiz Game
//
//  Created by APPLE on 08.10.2022.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    func saveUserSetting(data: ModelSetting) {
        
        if  let dataSetting = try? PropertyListEncoder().encode(data) {
            defaults.set(dataSetting, forKey: "UserSetting")
        }
    }
    
    func featchUserSetting() -> ModelSetting {
        
        guard let data = defaults.value(forKey: "UserSetting") as? Data,
              let model = try? PropertyListDecoder().decode(ModelSetting.self, from: data) else {
            return createStartSetting()
        }
        return model
    }
    
    func createStartSetting() -> ModelSetting {
        
        return ModelSetting.init(
            sounds: true,
            
            afterHelp: ModelSettingGame(
                name: "If incorrect answer",
                state: false,
                header: "Показывать подсказку",
                description: "Cразу после не правильного ответа показывать подсказку?",
                selectedState: [ModelDetailSetting(
                    nameRezult: "On",
                    isSelected: false),
                                ModelDetailSetting(
                                    nameRezult: "Off",
                                    isSelected: true)]),
            
            transitionAfterHelp: ModelSettingGame(
                name: "Transition after help",
                state: false, header: "Переходить сразу",
                description: "Переходить сразу после подсказки?",
                selectedState: [ModelDetailSetting(
                    nameRezult: "On",
                    isSelected: false),
                                ModelDetailSetting(
                                    nameRezult: "Off",
                                    isSelected: true)]),
            
            randomQuestion: false)
    }
    
    func firstLaunch() {
        let settingForGame = createStartSetting()
        self.saveUserSetting(data: settingForGame)
    }
}

