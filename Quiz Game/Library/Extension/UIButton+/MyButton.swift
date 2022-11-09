//
//  MyButton.swift
//  Quiz Game
//
//  Created by APPLE on 03.11.2022.
//

import UIKit

struct ModelButton {
    let title: String
    let image: UIImage?
}

final class MyButton: UIButton {
    
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

    private let myImage = UIImageView()
        .setMyStyle()
    
    private let containerForButton = UIStackView()
        .myStyleStack(
            spacing: 4,
            alignment: .center,
            axis: .horizontal,
            distribution: .equalCentering,
            userInteraction: false)
    
    private func touchDown() {
        let scaleX = 0.98
        let scaleY = 0.98

        self.myTitleLabel.alpha = 0.5
        self.myImage.alpha = 0.5
        self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
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
        self.addSubview(containerForButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if myImage.image == nil {
            containerForButton.addArrangedSubview(myTitleLabel)

        } else {
            containerForButton.addArrangedSubview(myTitleLabel)
            containerForButton.addArrangedSubview(myImage)
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            myImage.widthAnchor.constraint(equalToConstant: 40),
            myImage.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            containerForButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerForButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
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
            self.myImage.alpha = 1
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        })
    }
}
extension MyButton: ConfigurableView {
    typealias Model = ModelButton
    
    func configure(with model: ModelButton) {
        self.myTitleLabel.text = model.title
        self.myImage.image = model.image
    }
}
