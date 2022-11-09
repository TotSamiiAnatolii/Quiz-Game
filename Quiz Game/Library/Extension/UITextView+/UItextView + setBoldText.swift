//
//  UItextView + setBoldText.swift
//  Quiz Game
//
//  Created by APPLE on 15.08.2022.
//

import UIKit

extension UITextView {
    
    public func setBoldText() {
        let indexForCharacter = self.text.indexCharacter(of: ".") ?? -1
        let range = NSRange(location: 0, length: (indexForCharacter + 1))
        let attributedString = NSMutableAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .body).withSize(14)])
        
        attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range: range)
        
        self.attributedText = attributedString
    } 
}

