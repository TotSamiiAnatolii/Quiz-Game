//
//  UIStackView+ myStyle.swift
//  Quiz Game
//
//  Created by APPLE on 17.09.2022.
//

import UIKit

extension UIStackView {
    
    public func myStyleStack(spacing: CGFloat, alignment: UIStackView.Alignment, axis:NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, userInteraction: Bool ) -> Self {
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = userInteraction
        return self
    }
    
    public func setLayoutMargins(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        self.layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        self.isLayoutMarginsRelativeArrangement = true
        return self
    }
}
