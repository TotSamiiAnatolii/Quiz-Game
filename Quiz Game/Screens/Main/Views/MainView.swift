//
//  StartView.swift
//  Quiz Game
//
//  Created by APPLE on 08.07.2022.
//

import UIKit

final class MainView: UIView {
    
    //MARK: Properties
    private var onAction: ((ButtonType)->())?
    
    private let indent: CGFloat = 20

    private let headingIndent: CGFloat = 50

    private let headerLabel = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .largeTitle).withSize(70))

    private lazy var startButton = MyButton()
        .setMyStyle(backgroundColor: .white)
        .setShadow()
        .setTarget(method: #selector(actionButton),
                   target: self,
                   event: .touchUpInside)

    private lazy var selectedCategoryButton = SelectedButton()
        .setMyStyle(backgroundColor: .white)
        .setShadow()
        .setTarget(method: #selector(actionButton),
                   target: self,
                   event: .touchUpInside)

    private lazy var statisticButton = MyButton()
        .setMyStyle(backgroundColor: .white)
        .setShadow()
        .setTarget(method: #selector(actionButton),
                   target: self,
                   event: [ .touchUpInside])
    
    private lazy var settingButton = SettingButton(image: Image.buttonSetting!)
        .setMyStyle(backgroundColor: Colors.mainBackgroundColor)

        .setTarget(method: #selector(actionButton),
                   target: self,
                   event: .touchUpInside)
    
    private let containerForButton = UIStackView()
        .myStyleStack(
            spacing: 20,
            alignment: .fill,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: true)
        .setLayoutMargins(top: 0, left: 0, bottom: 0, right: 0)
 
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
        containerForButton.addArrangedSubview(statisticButton)
        containerForButton.addArrangedSubview(selectedCategoryButton)
        containerForButton.addArrangedSubview(startButton)
        
        self.addSubview(headerLabel)
        self.addSubview(settingButton)
        self.addSubview(containerForButton)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            statisticButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.56),
            statisticButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        NSLayoutConstraint.activate([
            selectedCategoryButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.56),
            selectedCategoryButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.56),
            startButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        NSLayoutConstraint.activate([
            containerForButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: headingIndent),
            containerForButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            settingButton.widthAnchor.constraint(equalToConstant: 40),
            settingButton.heightAnchor.constraint(equalToConstant: 40),
            settingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -indent),
            settingButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: indent)
        ])
    }

    @objc func actionButton(sender: UIButton) {
        
        switch sender {
        case startButton:
            onAction?(.start)
        case selectedCategoryButton:
            onAction?(.selected)
        case statisticButton:
            onAction?(.statistic)
        case settingButton:
            onAction?(.setting)
        default:
            break
        }
    }
}
extension MainView: ConfigurableView {
   
    typealias Model = ModelMainView
    
    func configure(with model: Model) {

        self.onAction = model.onAction
        self.headerLabel.text = model.header
        self.selectedCategoryButton.configure(with: ModelSelectedButton(
            title: model.category,
            subTitle: model.currentCategory,
            arrowImage: Image.rightArrow))
        self.startButton.configure(with: ModelButton(
            title: model.buttonStartLabel,
            image: Image.start))
        self.statisticButton.configure(with: ModelButton(
            title: model.buttonStatisticsLabel,
            image: Image.logoStatistic))
    }
}
