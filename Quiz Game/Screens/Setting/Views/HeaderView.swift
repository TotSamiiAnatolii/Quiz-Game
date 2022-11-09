//
//  HeaderView.swift
//  Quiz Game
//
//  Created by APPLE on 05.11.2022.
//

import UIKit

final class HeaderView: UIView {
    
    private let leftIndent: CGFloat = 10
    
    private let headerLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: UIFont.boldSystemFont(ofSize: 34))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackgroundColor
        setViewHierarhies()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(headerLabel)
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftIndent),
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    public func configureView(title: String) {
        self.headerLabel.text = title
    }
}
