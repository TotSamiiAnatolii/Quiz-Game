//
//  String +.swift
//  Quiz Game
//
//  Created by USER on 07.08.2022.
//

import Foundation

extension String {
    
    public func indexCharacter(of char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }
    
    public func fetchString() -> String {
        return  self.components(separatedBy: ".").last!.trimmingCharacters(in: .whitespaces)
    }
}
