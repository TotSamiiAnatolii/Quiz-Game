//
//  DetailFooterView.swift
//  Quiz Game
//
//  Created by APPLE on 05.11.2022.
//

import UIKit

final class DetailFooterView: UIView {

    private let leftIndent: CGFloat = 20
    
    private let headerLabel = UILabel()
        .setMyStyle(
            numberOfLines: 0,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .body).withSize(13))
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
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
    
    public func configureView(title: String?) {
        self.headerLabel.text = title
    }
}
