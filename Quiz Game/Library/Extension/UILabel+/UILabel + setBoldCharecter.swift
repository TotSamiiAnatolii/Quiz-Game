//
//  UILabel+setBoldText.swift
//  Quiz Game
//
//  Created by APPLE on 15.08.2022.
//

import UIKit

extension UILabel{
    
    public func setBoldCharecter() {
        let range = NSRange(location: 0, length: 2)
        
        let attributedString = NSMutableAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .title1).withSize(16)])
        
        attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)], range: range)
        
        self.attributedText = attributedString
    }
}
