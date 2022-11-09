//
//  ContainerQuestionView.swift
//  Quiz Game
//
//  Created by APPLE on 27.07.2022.
//

import UIKit

final class ContainerQuestionView: UIView {
    
    //MARK: Properties
    private var numberOfCardsToPack: Int = 0
    
    private var cardsToBeVisible: Int = 0
    
    private var cardViews: [QuestionView] = []
    
    private var visibleCards: [QuestionView] {
        return subviews as? [QuestionView] ?? []
    }
    
    public var delegate: ContainerQuestionViewDelegate!
    
    public var dataSource: ContainerQuestionViewDataSource? {
        didSet {
            removeAllCardViews()
            guard let dataSource = dataSource else {return}
            numberOfCardsToPack = dataSource.numberOfQuestionToShow()
            cardsToBeVisible = numberOfCardsToPack
            setNeedsLayout()
            layoutIfNeeded()
            for i in 0..<min(numberOfCardsToPack, cardsToBeVisible) {
                addCardView(cardView: dataSource.containerView(createQuestionView: i), atIndex: i)
            }
        }
    }
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func removeAllCardViews() {
        for cardView in visibleCards {
            cardView.removeFromSuperview()
        }
        cardViews = []
    }
    
    private func addCardView(cardView: QuestionView, atIndex index: Int) {
        cardView.delegate = self
        addCardFrame(index: index, cardView: cardView)
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
    }
    
    private func addCardFrame(index: Int, cardView: QuestionView) {
        let cardViewFrame = bounds
        cardView.frame = cardViewFrame
        setShadowCartView(cardView: cardView)
    }
    
    private func setShadowCartView(cardView: QuestionView) {
        cardView.layer.cornerRadius = 20
        cardView.clipsToBounds = true
        cardView.layer.shadowColor = #colorLiteral(red: 0.8106120907, green: 0.7866768516, blue: 1, alpha: 1)
        cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cardView.layer.shadowRadius = 5.0
        cardView.layer.shadowOpacity = 3
        cardView.layer.masksToBounds = false
    }
    
    public func deleteCard(bool: Bool) {
        guard let card = subviews.last as? QuestionView else {return}
        
        let abroad: CGFloat = card.bounds.width * 1.22
        
        let angleOfRotation: CGFloat = .pi / 12
        
        let axisOffsetY: CGFloat = 75
        
        if bool {
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.4, options: []) {
                card.transform = CGAffineTransform(rotationAngle: angleOfRotation)
                card.center = CGPoint(x: card.center.x + abroad, y: card.center.y + axisOffsetY)
                card.layoutIfNeeded()
            } completion: { _ in
                self.setQestionCard(on: card, correct: bool)
            }
        } else {
            
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.4, options: []) {
                card.transform = CGAffineTransform(rotationAngle: -angleOfRotation)
                card.center = CGPoint(x: card.center.x  - abroad, y: card.center.y + axisOffsetY)
                card.layoutIfNeeded()
            } completion: { _ in
                self.setQestionCard(on: card, correct: bool)
            }
        }
    }
    
    private func setQestionCard(on view: QuestionView, correct: Bool) {
        view.removeFromSuperview()
        delegate.questionCounting(correctAnswer: correct)
    }
}

//MARK: Extension
extension ContainerQuestionView: QuestionViewDelegate {
    
    func tapButton(answer: UIButton, view: QuestionView) {
        delegate.containerView(answer: answer, view: view)
    }
}
