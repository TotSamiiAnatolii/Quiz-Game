//
//  SelectedButton.swift
//  Quiz Game
//
//  Created by USER on 06.11.2022.
//

import UIKit

struct ModelSelectedButton {
    let title: String
    let subTitle: String
    let arrowImage: UIImage?
}

final class SelectedButton: UIButton {

    private var model: ModelSelectedButton?
    
    private let leftIndentForButton: CGFloat = 15
    
    private let rightIndentForButton: CGFloat = 15
    
    override var isHighlighted: Bool {
        
        didSet {
            if isHighlighted {
                touchDown()
            } else {
                touchUp()
            }
        }
    }
    
    private let myTitleLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: AppDesign.fontForButton)
    
    private let mySubTitleLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .right,
            font: UIFont.preferredFont(forTextStyle: .title1).withSize(13))
        .setTextColor(color: Colors.textColor)
    
    private let arrowImage = UIImageView()
        .setMyStyle()

    private let containerForButton = UIStackView()
        .myStyleStack(
            spacing: 4,
            alignment: .leading,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: false)
        .setLayoutMargins(top: 0, left: 10, bottom: 0, right: 5)
    
    private func touchDown() {
        let scaleX = 0.98
        let scaleY = 0.98
        
        self.myTitleLabel.alpha = 0.5
        self.mySubTitleLabel.alpha = 0.5
        self.arrowImage.alpha = 0.5
        self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    }
    
    private func  touchUp() {
        let scaleX = 1.0
        let scaleY = 1.0
        
        UIView.animateKeyframes(withDuration: 0.4,
                                delay: 0,
                                options: [.beginFromCurrentState,
                                          .allowUserInteraction],
                                animations: {
            self.myTitleLabel.alpha = 1
            self.mySubTitleLabel.alpha = 1
            self.arrowImage.alpha = 1
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        })
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarhies()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarhies() {
        containerForButton.addArrangedSubview(myTitleLabel)
        containerForButton.addArrangedSubview(mySubTitleLabel)
        self.addSubview(containerForButton)
        self.addSubview(arrowImage)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
        arrowImage.widthAnchor.constraint(equalToConstant: 20),
        arrowImage.heightAnchor.constraint(equalToConstant: 20),
        arrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -leftIndentForButton),
        arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerForButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: rightIndentForButton),
            containerForButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
extension SelectedButton: ConfigurableView {
    
    typealias Model = ModelSelectedButton
    
    func configure(with model: ModelSelectedButton) {
        self.myTitleLabel.text = model.title
        self.mySubTitleLabel.text = model.subTitle
        self.arrowImage.image = model.arrowImage
    }
}
