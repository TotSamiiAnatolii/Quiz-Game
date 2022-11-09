//
//  UIButton + MyStyles.swift
//  Quiz Game
//
//  Created by APPLE on 17.09.2022.
//

import UIKit

extension UIButton {
    
    public typealias Func = () -> ()
    
    public func setMyStyle(backgroundColor: UIColor) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = AppDesign.mainCornerRadius
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = false
        return self
    }
    
    public func setTarget( method methodDown: Selector, target: Any, event: UIControl.Event ) -> Self {

        self.addTarget(target, action: methodDown.self, for: event)
        
        return self
    }
    
    public func setShadow() -> Self {
        self.layer.shadowColor = Colors.shadowColor
        self.layer.shadowOffset = CGSize(width: 0.1, height: 3.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        return self
    }
    
    public func addImage(image: UIImage?) -> Self {
        guard let image = image else {return self}
        let highlighted = image.withAlpha(0.5)
        self.setImage(image, for: .normal)
        self.setImage(highlighted, for: .highlighted)
        return self
    }
    
    public func setStyleTitle(color: UIColor, font: UIFont) -> Self {
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = font
        return self
    }
}
extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}
