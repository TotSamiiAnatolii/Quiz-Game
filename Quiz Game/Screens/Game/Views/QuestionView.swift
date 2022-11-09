//
//  QuestionView.swift
//  Quiz Game
//
//  Created by APPLE on 27.07.2022.
//

import UIKit

final class QuestionView: UIView {
    
    //MARK: Properties
    private let indent: CGFloat = 15
    
    public var delegate: QuestionViewDelegate?

    private let photoQuestion = UIImageView()
        .setMyStyle()
        .setRoundCorners(radius: 15)
    
    private let questionPanelView = UIStackView()
        .myStyleStack(
            spacing: 5,
            alignment: .center,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: false)
        .setLayoutMargins(top: 14, left: 4, bottom: 3, right: 4)
    
    private let answerStackView = UIStackView()
        .myStyleStack(
            spacing: 10,
            alignment: .fill,
            axis: .vertical,
            distribution: .fillEqually,
            userInteraction: true)

    private let questionLabel = UILabel()
        .setMyStyle(numberOfLines: 0,
                    textAlignment: .center,
                    font: UIFont.preferredFont(forTextStyle: .title3))
        .setLineBreakMode(lineBreak: .byTruncatingHead)
        .setTextColor(color: #colorLiteral(red: 0.2809401249, green: 0.3038422874, blue: 0.3331686796, alpha: 1))
    
    private func createButtonAnswer() {
        
        let button = UIButton()
            .setMyStyle(backgroundColor: .white)
            .setTarget(method: #selector(startAction),
                       target: self,
                       event: .touchUpInside)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.answerButtonBorederColor
        answerStackView.addArrangedSubview(button)
    }
    
    private func setButtonTitle(answer: [String]) {
        
        for (index, value) in answerStackView.subviews.enumerated() {
            guard let button = value as? UIButton else {return}
            button.setTitle("\(prefixForAnswer(index: index)).  \(answer[index])", for: .normal)
            
            button.titleLabel?.setBoldCharecter()
            button.titleLabel?.lineBreakMode = .byWordWrapping
            button.titleLabel?.numberOfLines = 2
            button.setTitleColor(#colorLiteral(red: 0.2809401249, green: 0.3038422874, blue: 0.3331686796, alpha: 1), for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.2809401249, green: 0.3038422874, blue: 0.3331686796, alpha: 0.5), for: .highlighted)
        }
    }
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(questionPanelView)
        self.addSubview(answerStackView)
    }
    
    public func selectedAnswerButton(sender: UIButton) {
        
        let scaleX = 0.9
        let scaleY = 0.9
        
        sender.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            if  sender.isSelected {
                
                sender.setTitleColor(.white, for: .normal)
                sender.backgroundColor = Colors.correctAnswer
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
            } else {
                
                sender.setTitleColor(.white, for: .normal)
                sender.backgroundColor = Colors.noCorrectAnswer
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    private func setConstraints() {
                
        NSLayoutConstraint.activate([
            questionPanelView.widthAnchor.constraint(equalTo: self.widthAnchor),
            questionPanelView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55),
            questionPanelView.topAnchor.constraint(equalTo: self.topAnchor),
            questionPanelView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
                
        NSLayoutConstraint.activate([
            answerStackView.topAnchor.constraint(equalTo: questionPanelView.bottomAnchor, constant: indent),
            answerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: indent),
            answerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -indent),
            answerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -indent)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if photoQuestion.image == nil {
            questionPanelView.addArrangedSubview(questionLabel)
        } else {
            questionPanelView.addArrangedSubview(photoQuestion)
            questionPanelView.addArrangedSubview(questionLabel)
        }
    }
    
    @objc func startAction(sender: UIButton) {
        
        delegate?.tapButton(answer: sender, view: self)
    }
    
    private func prefixForAnswer(index: Int) -> String {
        let startChar = "A"
        
        guard let uInt32 = startChar.unicodeScalars.first?.value else {return ""}
        
        let indexForCharacter = Int(uInt32) + index
        
        if let scalar = UnicodeScalar(indexForCharacter) {
            return "\(Character(scalar))"
        }
        return ""
    }
}
//MARK: Extension
extension QuestionView: ConfigurableView {
   
    typealias Model = ModelQuestionView
    
    func configure(with model: Model) {
        questionLabel.text = model.question
        
        photoQuestion.image = model.photoQuestion
        
        model.answer.forEach { _ in

            createButtonAnswer()
        }
        setButtonTitle(answer: model.answer)
    }
}
