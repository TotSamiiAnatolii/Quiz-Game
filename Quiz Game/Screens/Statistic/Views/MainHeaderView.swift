//
//  HeaderView.swift
//  Quiz Game
//
//  Created by APPLE on 07.09.2022.
//

import UIKit

final class MainHeaderView: UIView {
    
    //MARK: Properties
    private let headingIndent: CGFloat = 20
    
    private let topIndent: CGFloat = 5
    
    private let rightIndent: CGFloat = 5
    
    private let coverContainerProgressView = UIView()
        .setStyle()
        .setShadows(
            color: Colors.progressShadow,
            width: 0.1,
            height: 2,
            radius: 3,
            opacity: 2)
    
    private let headerProgressLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.titleHeaderStatistic)

    private let statisticLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.rezultGames)
        .setTextColor(color: Colors.textColor)
        
    private let progressLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.rezultGames)
        .setTextColor(color: Colors.textColor)
    
    private let startPositionLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.startEndPosition)
        .setTextColor(color: Colors.textColor)

    private let endPositionLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.startEndPosition)
        .setTextColor(color: Colors.textColor)

    public let imageGeoTag = UIImageView()
        .setMyStyle()
        .setImage(image: Image.progress)
    
    public let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = Colors.progressTintColor
        progress.trackTintColor = Colors.trackTintColor
        progress.progress = 0
        progress.clipsToBounds = true
        progress.layer.cornerRadius = 2
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private let containerView = UIView()
        .setStyle()
        .setRoundCorners(radius: AppDesign.mainCornerRadius)
    
    private let containerStatisticLabel = UIStackView()
        .myStyleStack(
            spacing: 6,
            alignment: .leading,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: false)
        .setLayoutMargins(top: 20, left: 20, bottom: 5, right: 10)
    
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
        containerView.addSubview(coverContainerProgressView)
        coverContainerProgressView.addSubview(progressView)
        containerStatisticLabel.addArrangedSubview(progressLabel)
        containerStatisticLabel.addArrangedSubview(statisticLabel)
        containerView.addSubview(containerStatisticLabel)
        containerView.addSubview(imageGeoTag)
        containerView.addSubview(startPositionLabel)
        containerView.addSubview(endPositionLabel)
        containerView.addSubview(headerProgressLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            headerProgressLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: headingIndent),
            headerProgressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: headingIndent)
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 5),
            progressView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            progressView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            coverContainerProgressView.heightAnchor.constraint(equalToConstant: 5),
            coverContainerProgressView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            coverContainerProgressView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            coverContainerProgressView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageGeoTag.heightAnchor.constraint(equalToConstant: 40),
            imageGeoTag.widthAnchor.constraint(equalToConstant: 40),
            imageGeoTag.bottomAnchor.constraint(equalTo: progressView.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            startPositionLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: topIndent),
            startPositionLabel.trailingAnchor.constraint(equalTo: progressView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            endPositionLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: topIndent),
            endPositionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -rightIndent)
        ])
        
        NSLayoutConstraint.activate([
            containerStatisticLabel.leadingAnchor.constraint(equalTo: headerProgressLabel.leadingAnchor),
            containerStatisticLabel.topAnchor.constraint(equalTo: startPositionLabel.bottomAnchor)
        ])
    }
    
    public func animationGeoTag(progress: Float) {
        var constraint: NSLayoutConstraint?
        
        progressView.progress = progress
        
        let percent = (progressView.bounds.width) * CGFloat(progress)
        
        constraint = imageGeoTag.centerXAnchor.constraint(equalTo: progressView.leadingAnchor)
        constraint?.isActive = true
        constraint?.constant += percent
        
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseIn,
            animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: Extension
extension MainHeaderView: ConfigurableView {

    typealias Model = ModelMainHeaderView
    
    func configure(with model: Model) {
        let progress = "\(String(format: "%.1f", model.progressLabel))"
        self.headerProgressLabel.text = model.header
        self.progressLabel.text = "Current progress: \(progress)%"
        self.statisticLabel.text = "Total games: \(model.statisticLabel)"
        self.startPositionLabel.text = model.startPositionLabel
        self.endPositionLabel.text = model.endPositionLabel
    }
}
