//
//  DetailHistoryGameCell.swift
//  Quiz Game
//
//  Created by APPLE on 08.09.2022.
//

import UIKit

enum Corner {
    case top, bottom, full
}

final class DetailHistoryGameCell: UITableViewCell {
    
    //MARK: Properties
    static let identifire = "DetailHistoryGameCell"
    
    private var constraint: NSLayoutConstraint?
    
    private var photoRatio: CGFloat = 0
    
    private let indent: CGFloat = 15
    
    private var onAction: (()->())?
    
    private let topSeparator = UIView(frame: .zero)
    
    private let bottomSeparator = UIView(frame: .zero)
    
    private let answerStateImage = UIImageView()
        .setMyStyle()

    private let photoQuestion = UIImageView()
        .setMyStyle()
        .setRoundCorners(radius: 15)

    public let questionPanelView = UIStackView()
        .myStyleStack(
            spacing: 12,
            alignment: .fill,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: true)
        .setLayoutMargins(top: 15, left: 0, bottom: 15, right: 10)
    
    private var questionLabel = UILabel()
        .setMyStyle(
            numberOfLines: 0,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .body).withSize(16))
        .setTextColor(color: .black)
    
    private let myAnswerLabel = UILabel()
        .setMyStyle(
            numberOfLines: 0,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .body).withSize(15))
        .setTextColor(color: Colors.textColor)
    
    private lazy var helpButton = MyButton()
        .setMyStyle(backgroundColor: Colors.mainBackgroundColor)
        .setShadow()
        .setStyleTitle(color: .black, font: AppDesign.fontForButton)
        .setTarget(method:  #selector(helpButtonAction),
                   target: self,
                   event: .touchUpInside)

    //MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupViewHierarhies()
        setConstraints()
        setupSeparators()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: .zero)
        questionPanelView.subviews.forEach { subview in
            questionPanelView.removeArrangedSubview(subview)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

            constraint = photoQuestion.heightAnchor.constraint(equalToConstant: 200)
            constraint?.isActive = true
        
        if photoQuestion.image == nil {
            questionPanelView.addArrangedSubview(questionLabel)
            questionPanelView.addArrangedSubview(myAnswerLabel)
            questionPanelView.addArrangedSubview(helpButton)
        } else {
            questionPanelView.addArrangedSubview(photoQuestion)
            questionPanelView.addArrangedSubview(questionLabel)
            questionPanelView.addArrangedSubview(myAnswerLabel)
            questionPanelView.addArrangedSubview(helpButton)
        }
    }
    
    private func setupViewHierarhies() {
        contentView.addSubview(answerStateImage)
        contentView.addSubview(questionPanelView)
        contentView.addSubview(topSeparator)
        contentView.addSubview(bottomSeparator)
    }
    
    private func setConstraints() {
        
        let questionPanelViewBottomConstraint =   questionPanelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        questionPanelViewBottomConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            answerStateImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent),
            answerStateImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent),
            answerStateImage.widthAnchor.constraint(equalToConstant: 30),
            answerStateImage.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            questionPanelView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            questionPanelViewBottomConstraint,

            questionPanelView.leadingAnchor.constraint(equalTo: answerStateImage.trailingAnchor, constant: indent),

            questionPanelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            helpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupSeparators() {
        
        topSeparator.backgroundColor = Colors.separatorColor
        bottomSeparator.backgroundColor = Colors.separatorColor
        
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: questionPanelView.leadingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 0.3),
            
            bottomSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: topSeparator.trailingAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: topSeparator.leadingAnchor),
            bottomSeparator.heightAnchor.constraint(equalTo: topSeparator.heightAnchor)
        ])
    }
    
    public func setSeparator(indexPath: IndexPath, count: Int) {
        let lastCell = count - 1
        
        switch indexPath.row {
        case 0 :
            topSeparator.isHidden = true
            if indexPath.row == lastCell {
                bottomSeparator.isHidden = true
            }
        case lastCell:
            bottomSeparator.isHidden = true
        default:
            topSeparator.isHidden = false
            bottomSeparator.isHidden = false
        }
    }
    
    public func setCornerRadius(indexPath: IndexPath, count: Int) {
        let lastCell = count - 1
        switch indexPath.row {
        case 0:
            self.roundCorners([.topLeft, .topRight],
                              radius: AppDesign.mainCornerRadius)
            if indexPath.row == lastCell {
                self.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight],
                                  radius: AppDesign.mainCornerRadius)
            }
        case lastCell:
            self.roundCorners([.bottomLeft, .bottomRight],
                              radius: AppDesign.mainCornerRadius)
        default:
            break
        }
    }
    
    private func setAnswerStateImage(answer: Bool) {
        if answer {
            answerStateImage.image = Image.correctAnswer
        } else {
            answerStateImage.image = Image.noCorrectAnswer
        }
    }
    
    @objc func helpButtonAction(sender: UIButton) {
        onAction?()
    }
}
//MARK: Extension
extension DetailHistoryGameCell: ConfigurableView {
    typealias Model = ModelDetailStatisticCell
    
    func configure(with model: ModelDetailStatisticCell) {
        self.onAction = model.onAction
        self.questionLabel.text = model.textQuestion
        self.myAnswerLabel.text = "My answer: \(model.myAnswer)"
        setAnswerStateImage(answer: model.isAnswer)
        self.photoQuestion.image = model.photoQuestion
        self.helpButton.configure(with: ModelButton(
            title: model.correctAnswer,
            image: nil))
        layoutIfNeeded()
    }
}
