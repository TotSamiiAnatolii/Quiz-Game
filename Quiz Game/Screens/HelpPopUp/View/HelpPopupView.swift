//
//  HelpPopupView.swift
//  Quiz Game
//
//  Created by APPLE on 16.07.2022.
//

import UIKit

final class HelpPopupView: UIView {
    
    //MARK: Properties
    private var onReturnGameAction: (()->())?
    
    private let topIndent: CGFloat = 8

    private let teoryLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .headline).withSize(21))
    
    private let imageForTheory: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = Image.scientist
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    public var visualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blur = UIVisualEffectView(frame: UIScreen.main.bounds)
        blur.alpha = 0.95
        blur.effect = blurEffect
        return blur
    }()
    
    public lazy var closedButton = UIButton()
        .setMyStyle(backgroundColor: .white)
        .setTarget(method: #selector(returnGameButtonAction),
                   target: self,
                   event: .touchUpInside)
        .addImage(image: Image.cancel)
    
    private let containerView = UIView()
        .setStyle()
        .setRoundCorners(radius: AppDesign.mainCornerRadius)
        .setShadows(
            color: Colors.helpShadow,
            width: 0.1,
            height: 3,
            radius: 5,
            opacity: 4)
    
    private let containerForHeader = UIStackView()
        .myStyleStack(
            spacing: 10,
            alignment: .fill,
            axis: .horizontal,
            distribution: .equalCentering,
            userInteraction: false)
    
    private let textHelp: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .body).withSize(15)
        textView.layer.cornerRadius = AppDesign.mainCornerRadius
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return textView
    }()

    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        setupViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarhies() {
        self.addSubview(visualEffect)
        self.addSubview(closedButton)
        containerView.addSubview(containerForHeader)
        containerForHeader.addArrangedSubview(teoryLabel)
        containerForHeader.addArrangedSubview(imageForTheory)
        containerView.addSubview(textHelp)
        self.addSubview(containerView)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            imageForTheory.widthAnchor.constraint(equalToConstant: 35),
            imageForTheory.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            textHelp.topAnchor.constraint(equalTo: containerForHeader.bottomAnchor),
            textHelp.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textHelp.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textHelp.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.92),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerForHeader.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            containerForHeader.topAnchor.constraint(equalTo: containerView.topAnchor, constant: topIndent)
        ])
        
        NSLayoutConstraint.activate([
            closedButton.widthAnchor.constraint(equalToConstant: 35),
            closedButton.heightAnchor.constraint(equalToConstant: 35),
            closedButton.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -topIndent),
            closedButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    @objc func returnGameButtonAction() {
        onReturnGameAction?()
    }
}
extension HelpPopupView: ConfigurableView {
    
    typealias Model = ModelHelpPopUpView
    
    func configure(with model: Model) {
        self.onReturnGameAction = model.onReturnGameAction
        self.teoryLabel.text = model.header
        self.textHelp.text = model.textHelp
        self.textHelp.setBoldText()
    }
}
