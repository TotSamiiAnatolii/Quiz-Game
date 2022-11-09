//
//  SettingCell.swift
//  Quiz Game
//
//  Created by APPLE on 07.10.2022.
//

import UIKit

final class SettingCell: UITableViewCell {
    
    //MARK: Properties
    static let identifire = "SettingCell"
    
    private var onAction: (()->())?
    
    private let topSeparator = UIView(frame: .zero)
    
    private let bottomSeparator = UIView(frame: .zero)
    
    private let indent: CGFloat = 20
    
    private let rightIndent: CGFloat = 8
    
    public var topCell: Bool = false {
        didSet {
            if topCell {
                self.roundCorners([.topLeft, .topRight],
                                  radius: AppDesign.mainCornerRadius)
            } else {
                self.roundCorners([.topLeft, .topRight], radius: .zero)
            }
        }
    }
    
    public var bottomCell: Bool = false {
        didSet {
            if bottomCell {
                self.roundCorners([.bottomLeft, .bottomRight],
                                  radius: AppDesign.mainCornerRadius)
            } else {
                self.roundCorners([.bottomLeft, .bottomRight], radius: .zero)
            }
        }
    }
    
    public var fullCornerRadiusCell: Bool = false {
        didSet {
            if fullCornerRadiusCell {
                self.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight],
                                  radius: AppDesign.mainCornerRadius)
            } else {
                self.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: .zero)
            }
        }
    }

    public var titleLabel = UILabel()
        .setMyStyle(
            numberOfLines: 0,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .largeTitle).withSize(17))
        .setTextColor(color: Colors.textColor)
    
    public var detailText = UILabel()
        .setMyStyle(
            numberOfLines: 0,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .largeTitle).withSize(17))
        .setTextColor(color: .gray)
    
    public let logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    //MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarhies()
        setConstraints()
        setupSeparators()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarhies() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(logoImage)
        contentView.addSubview(topSeparator)
        contentView.addSubview(bottomSeparator)
        contentView.addSubview(detailText)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: 35),
            logoImage.widthAnchor.constraint(equalToConstant: 35),
            logoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: indent),
        ])
        
        NSLayoutConstraint.activate([
            detailText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            detailText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -rightIndent),
        ])
    }
    
    private func setupSeparators() {
        
        topSeparator.backgroundColor = Colors.separatorColor
        bottomSeparator.backgroundColor = Colors.separatorColor
        
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 0.3),
            
            bottomSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: topSeparator.trailingAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: topSeparator.leadingAnchor),
            bottomSeparator.heightAnchor.constraint(equalTo: topSeparator.heightAnchor)
        ])
    }
    
    public func setup(hideTopSeparator: Bool, hideBotSeparator: Bool) {
        topSeparator.isHidden = hideTopSeparator
        bottomSeparator.isHidden = hideBotSeparator
    }
    
    @objc func helpButtonAction(sender: UIButton) {
        onAction?()
    }
}

extension SettingCell: ConfigurableView {

    typealias Model = ModelSettingCell
    
    func configure(with model: Model) {
        self.titleLabel.text = model.titleLabel
        self.logoImage.image = model.logoImage
        self.detailText.text = model.detailText
    }
    
}
