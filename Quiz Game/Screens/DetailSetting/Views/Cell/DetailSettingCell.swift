//
//  DetailSettingCell.swift
//  Quiz Game
//
//  Created by APPLE on 07.10.2022.
//

import UIKit

final class DetailSettingCell: UITableViewCell {
    
    //MARK: Properties
    static let identifire = "DetailSettingCell"
    
    private var onAction: (()->())?
    
    private let topSeparator = UIView(frame: .zero)
    
    private let bottomSeparator = UIView(frame: .zero)
    
    private let indent: CGFloat = 20
    
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

    private var stateLabel = UILabel()
        .setMyStyle(
            numberOfLines: 0,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .largeTitle).withSize(17))
        .setTextColor(color: Colors.textColor)
    
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
        contentView.addSubview(stateLabel)
        contentView.addSubview(topSeparator)
        contentView.addSubview(bottomSeparator)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            stateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent),
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
            topSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent),
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
//MARK: Extension
extension DetailSettingCell: ConfigurableView {
    typealias Model = ModelDetailSettingCell

    func configure(with model: ModelDetailSettingCell) {
        self.stateLabel.text = model.state
    }
}
