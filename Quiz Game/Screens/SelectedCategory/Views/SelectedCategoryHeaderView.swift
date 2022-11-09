//
//  SelectedCategoryHeaderView.swift
//  Quiz Game
//
//  Created by APPLE on 27.10.2022.
//

import UIKit

final class SelectedCategoryHeaderView: UIView {
    
    //MARK: Properties
    private let leftIndent: CGFloat = 10
    
    private let topIndent: CGFloat = 5
    
    private let headerLabel = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: AppDesign.fohtForHeader)
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.mainBackgroundColor
        setViewHierarchies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViewHierarchies() {
        self.addSubview(headerLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftIndent),
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: topIndent)
        ])
    }
    
    public func configureView(header: String?) {
        guard let header = header else { return }

        self.headerLabel.text = header
    }
}
