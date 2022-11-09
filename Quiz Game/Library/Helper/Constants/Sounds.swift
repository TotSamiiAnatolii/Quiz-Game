//
//  ConstantsSounds.swift
//  Quiz Game
//
//  Created by APPLE on 05.09.2022.
//

import Foundation
import AVFoundation
import AudioToolbox

final class SoundPlayer {
    
    static let shared = SoundPlayer()
    
    var audioPlayer = AVAudioPlayer()
    
    private init() {
        
    }
    
     var tapButtonSound: URL {
        guard let path = Bundle.main.path(forResource: "tapButton", ofType: "wav") else {return URL(fileURLWithPath: "")}
        
        return URL(fileURLWithPath: path)
    }
    
     var answerTrueSound: URL {
        guard let path = Bundle.main.path(forResource: "correctAnswer", ofType: "wav") else {return URL(fileURLWithPath: "")}
        
        return URL(fileURLWithPath: path)
    }
    
     var answerFalseSound: URL {
        guard let path = Bundle.main.path(forResource: "noCorrectAnswer", ofType: "wav") else {return URL(fileURLWithPath: "")}
        
        return URL(fileURLWithPath: path)
    }
    
     func setButtonTapSound(sound: URL, setting: Bool?) {
        
        guard let settingSound = setting else {return}
        
        if settingSound {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: sound)
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
}

