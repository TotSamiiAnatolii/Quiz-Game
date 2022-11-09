//
//  HistoryGameCell.swift
//  Quiz Game
//
//  Created by APPLE on 08.09.2022.
//

import UIKit

final class HistoryGameCell: UITableViewCell {
    
    //MARK: Properties
    static let identifire = "HistoryGameCell"
    
    private let topSeparator = UIView(frame: .zero)
    
    private let bottomSeparator = UIView(frame: .zero)
    
    private let indent: CGFloat = 15
    
    private let nameGameLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.nameGameStatistic)
        .setTextColor(color: .black)
    
    private let dateGameLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.fontDateGame)
        .setTextColor(color: Colors.textColor)
    
    private let progressLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: AppDesign.progressStatistic)
        .setTextColor(color: Colors.textColor)
    
    private let dateImage = UIImageView()
        .setMyStyle()
        .setImage(image: Image.calendar)
    
    private let containerStateView = UIView()
        .setStyle()
    
    private let containerForDate = UIStackView()
        .myStyleStack(
            spacing: 4,
            alignment: .fill,
            axis: .horizontal,
            distribution: .fill,
            userInteraction: false)
    
    private let mainContainerStatistic = UIStackView()
        .myStyleStack(
            spacing: 4,
            alignment: .fill,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: false)
    
    //MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarhies()
        setConstraints()
        setupSeparators()
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerStateView.setShadow(
            color: Colors.shadowColor,
            width: 0.1,
            height: 2.0,
            radius: 2,
            opacity: 3)
        
        containerStateView.layer.cornerRadius = AppDesign.cornerRadiusStatistic
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: .zero)
    }
    
    private func setupViewHierarhies() {
        contentView.addSubview(containerStateView)
        containerStateView.addSubview(progressLabel)
        contentView.addSubview(mainContainerStatistic)
        mainContainerStatistic.addArrangedSubview(nameGameLabel)
        contentView.addSubview(containerForDate)
        containerForDate.addArrangedSubview(dateImage)
        containerForDate.addArrangedSubview(dateGameLabel)
        mainContainerStatistic.addArrangedSubview(containerForDate)
        contentView.addSubview(topSeparator)
        contentView.addSubview(bottomSeparator)
    }
    
    private func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let formattedData = dateFormatter.string(from: date)
        return formattedData.uppercased()
    }
    
    private func setBorderProgressColor(progress: Float) {
        
        containerStateView.layer.borderWidth = 7
        
        switch progress {
        case 0...30:
            containerStateView.layer.borderColor = Colors.noCorrectAnswer.cgColor
        case 31...60:
            containerStateView.layer.borderColor = Colors.averageResult.cgColor
        case 61 ... 100:
            containerStateView.layer.borderColor = Colors.correctAnswer.cgColor
        default:
            break
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            containerStateView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85),
            containerStateView.widthAnchor.constraint(equalTo: containerStateView.heightAnchor),
            containerStateView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            containerStateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent)
        ])
        
        NSLayoutConstraint.activate([
            progressLabel.centerYAnchor.constraint(equalTo: containerStateView.centerYAnchor),
            progressLabel.centerXAnchor.constraint(equalTo: containerStateView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainContainerStatistic.centerYAnchor.constraint(equalTo: containerStateView.centerYAnchor),
            nameGameLabel.leadingAnchor.constraint(equalTo: containerStateView.trailingAnchor, constant: indent)
        ])
        
        NSLayoutConstraint.activate([
            dateImage.widthAnchor.constraint(equalToConstant: 18),
            dateImage.heightAnchor.constraint(equalToConstant: 18)
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
            topSeparator.leadingAnchor.constraint(equalTo: mainContainerStatistic.leadingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 0.5),
            
            bottomSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: topSeparator.trailingAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: topSeparator.leadingAnchor),
            bottomSeparator.heightAnchor.constraint(equalTo: topSeparator.heightAnchor)
        ])
    }
    
    public func setSeparator(indexPath: IndexPath, lastCell: Int) {

        let lastCell = lastCell - 1
        
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
    
    public func setCornerRadius(indexPath: IndexPath, lastCell: Int) {
        
        let lastCell = lastCell - 1
        
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
}
extension HistoryGameCell: ConfigurableView {
    typealias Model = ModelStatisticCell
    
    func configure(with model: ModelStatisticCell) {
        self.nameGameLabel.text = model.nameGame
        self.progressLabel.text = "\(String(format: "%.0f", model.progress))%"
        self.dateGameLabel.text = dateFormatter(date: model.dateGame)
        setBorderProgressColor(progress: model.progress)
    }
}
