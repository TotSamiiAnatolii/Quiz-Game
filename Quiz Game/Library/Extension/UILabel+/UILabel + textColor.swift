//
//  UILabel + textColor.swift
//  Quiz Game
//
//  Created by APPLE on 15.07.2022.
//

import UIKit

extension UILabel {
    
    public func setColorSelectedText(color: UIColor) {
        let range = NSRange(location: 0, length: 2)
        
        let attributedString = NSMutableAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.black])
        attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17),
                                        NSAttributedString.Key.foregroundColor : color ], range: range)
        
        self.attributedText = attributedString
    }
}
