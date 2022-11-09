//
//  DetailGameSecondHeaderVIew.swift
//  Quiz Game
//
//  Created by APPLE on 12.10.2022.
//

import UIKit

final class DetailGameSecondHeaderVIew: UIView {
        
    //MARK: Properties
    private let topIndent: CGFloat = 6
    
    private let indent: CGFloat = 10
    
    private let header = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.fohtForHeader)
        .setTextColor(color: Colors.textColor)
        
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
    
    // MARK: Setup ViewHierarhies
    private func setupViewHierarhies() {
        self.addSubview(header)
    }
    
    //MARK: Set Constraints
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: indent),
            header.topAnchor.constraint(equalTo: self.topAnchor, constant: topIndent)
        ])
    }
}
                                    
//MARK: Extension
extension DetailGameSecondHeaderVIew: ConfigurableView {

    typealias Model = ModelDetailStatisticSecondHeader

    func configure(with model: Model) {
        self.header.text = model.header
    }
}

