//
//  DetailHeaderView.swift
//  Quiz Game
//
//  Created by APPLE on 05.11.2022.
//

import UIKit

final class DetailHeaderView: UIView {
    
    private let leftIndent: CGFloat = 20
    
    private let headerLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .title1).withSize(15))
        .setTextColor(color: .gray)
    
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
    
    public func configureView(title: String?) {
        self.headerLabel.text = title
    }
}
