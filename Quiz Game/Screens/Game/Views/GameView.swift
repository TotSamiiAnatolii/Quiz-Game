//
//  MainView.swift
//  Quiz Game
//
//  Created by APPLE on 08.07.2022.
//

import UIKit

final class GameView: UIView {
    
    //MARK: Properties
    private var onBackAction: (()->())?
    
    private let offsetFromCenter: CGFloat = 40
    
    private let topIndent: CGFloat = 10
    
    private let indentFromTop: CGFloat = 5
    
    private let indent: CGFloat = 20
    
    private var onHelpAction: (()->())?
    
    public let helpPopUpView: HelpPopupView = {
        let view = HelpPopupView()
        view.alpha = 0
        return view
    }()
        
    public var containerView : ContainerQuestionView = {
        let container = ContainerQuestionView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let amountQuestionLabel = UILabel()
        .setMyStyle(numberOfLines: 1,
                    textAlignment: .left,
                    font: UIFont.boldSystemFont(ofSize: 17))
        .setTextColor(color: Colors.textColor)
    
    private lazy var backButton = UIButton()
        .setMyStyle(backgroundColor: .white)
        .setShadow()
        .addImage(image: Image.backButton)
        .setTarget(method: #selector(backButtonAction),
                   target: self,
                   event: .touchUpInside)
    
    private lazy var helpButton = UIButton()
        .setMyStyle(backgroundColor: Colors.mainBackgroundColor)
        .setShadow()
        .addImage(image: Image.helpButton)
        .setTarget(method: #selector(helpButtonAction),
                   target: self,
                   event: .touchUpInside)

    private let coverContainerProgressView = UIView()
        .setStyle()
        .setShadows(
            color: Colors.progressShadow,
            width: 0.1,
            height: 3,
            radius: 5,
            opacity: 1)
    
    private let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = Colors.progressTintColor
        progress.trackTintColor = Colors.trackTintColor
        progress.progress = 0
        progress.clipsToBounds = true
        progress.layer.sublayers?[1].cornerRadius = 4
        progress.layer.cornerRadius = 4
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.subviews[1].clipsToBounds = true
        return progress
    }()
    
    //MARK: Lifecycle
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
        self.addSubview(containerView)
        self.addSubview(amountQuestionLabel)
        self.addSubview(coverContainerProgressView)
        self.addSubview(backButton)
        self.addSubview(helpButton)
        coverContainerProgressView.addSubview(progressView)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.82),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: offsetFromCenter)
        ])
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 25),
            backButton.heightAnchor.constraint(equalToConstant: 25),
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: indentFromTop),
            backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: indent)
        ])
        
        NSLayoutConstraint.activate([
            helpButton.widthAnchor.constraint(equalToConstant: 25),
            helpButton.heightAnchor.constraint(equalToConstant: 25),
            helpButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: indentFromTop),
            helpButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -indent)
        ])
        
        NSLayoutConstraint.activate([
            coverContainerProgressView.heightAnchor.constraint(equalToConstant: 8),
            coverContainerProgressView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            coverContainerProgressView.topAnchor.constraint(equalTo: helpButton.bottomAnchor, constant: topIndent),
            coverContainerProgressView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 8),
            progressView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            progressView.topAnchor.constraint(equalTo: helpButton.bottomAnchor, constant: topIndent),
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            amountQuestionLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -topIndent),
            amountQuestionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    @objc func backButtonAction() {
        onBackAction?()
    }
    
    @objc func helpButtonAction() {
        onHelpAction?()
    }
}
//MARK: Extension
extension GameView: ConfigurableView {
   
    typealias Model = ModelGameView
    
    
    func configure(with model: Model) {
        self.onBackAction = model.onBackAction
        self.onHelpAction = model.onHelpAction
        self.amountQuestionLabel.text = "\(model.currentQuestion) / \(model.countQuestion) Question"
        self.progressView.progress = model.progres
        
        amountQuestionLabel.setColorSelectedText(color: #colorLiteral(red: 1, green: 0.686558111, blue: 0.4822032202, alpha: 1))
    }
    
}
