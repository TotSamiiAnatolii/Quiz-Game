//
//  HeaderView2.swift
//  Quiz Game
//
//  Created by APPLE on 13.09.2022.
//

import UIKit

final class SecondHeaderView: UIView {
    
    private var onAction: (()->())?
    
    private let topIndent: CGFloat = 6
    
    private let indent: CGFloat = 10
    
    //MARK: Properties
    private let header = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.fohtForHeader)
        .setTextColor(color: Colors.textColor)
    
    private lazy var deleteButton = UIButton()
        .setMyStyle(backgroundColor: Colors.mainBackgroundColor)
        .addImage(image: Image.trash)
        .setTarget(method: #selector(actionDeleteButton),
                   target: self,
                   event: .touchUpInside)
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackgroundColor
        setupViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup ViewHierarhies
    private func setupViewHierarhies() {
        self.addSubview(header)
        self.addSubview(deleteButton)
    }
    
    //MARK: Set Constraints
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: indent),
            header.topAnchor.constraint(equalTo: self.topAnchor, constant: topIndent)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 25),
            deleteButton.heightAnchor.constraint(equalToConstant: 28),
            deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -indent),
            deleteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: topIndent)
        ])
    }
    
    @objc func actionDeleteButton() {
        onAction?()
    }
}
//MARK: Extension
extension SecondHeaderView: ConfigurableView {
    
    typealias Model = ModelSecondHeaderView
    
    func configure(with model: Model) {
        self.onAction = model.onAction
        self.header.text = model.header
    }
}
