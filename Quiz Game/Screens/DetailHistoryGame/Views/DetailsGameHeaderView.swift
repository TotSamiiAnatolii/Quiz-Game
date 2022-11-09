//
//  DetailsGameHeaderView.swift
//  Quiz Game
//
//  Created by APPLE on 08.09.2022.
//

import UIKit

final class DetailsGameHeaderView: UIView {
    
    //MARK: Properties
    private let topIndent: CGFloat = 20
    
    private let indent: CGFloat = 20
    
    private let containerView = UIView()
        .setStyle()
        .setRoundCorners(radius: AppDesign.mainCornerRadius)

    private let headerLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.titleHeaderStatistic)

    private let numberOfQuestionsLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.rezultGames)
        .setTextColor(color: Colors.textColor)
    
    private let helpLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.rezultGames)
        .setTextColor(color: Colors.textColor)

    private let correctAnswersLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.rezultGames)
        .setTextColor(color: Colors.textColor)

    private let containerStatisticLabel = UIStackView()
        .myStyleStack(
            spacing: 6,
            alignment: .leading,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: false)
        .setLayoutMargins(top: 0, left: 15, bottom: 5, right: 10)
    
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
    
    private func setupViewHierarhies() {
        self.addSubview(containerView)
        containerStatisticLabel.addArrangedSubview(numberOfQuestionsLabel)
        containerStatisticLabel.addArrangedSubview(correctAnswersLabel)
        containerStatisticLabel.addArrangedSubview(helpLabel)
        containerView.addSubview(containerStatisticLabel)
        containerView.addSubview(headerLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topIndent),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: indent)
        ])
        
        NSLayoutConstraint.activate([
            containerStatisticLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            containerStatisticLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: topIndent)
        ])
    }
}

//MARK: Extension
extension DetailsGameHeaderView: ConfigurableView {

    typealias Model = ModelDetailHeaderStatistic
    
    func configure(with model: Model) {
        self.headerLabel.text = model.header
        self.helpLabel.text = "Help: \(model.help)"
        self.numberOfQuestionsLabel.text = "Number of questions: \(model.numberOfQuestions)"
        self.correctAnswersLabel.text = "Correct answers: \(model.correctAnswers)"
    }
}
