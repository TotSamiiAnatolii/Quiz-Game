     
//  DetailSettingView.swift
//  Quiz Game
//
//  Created by USER on 11.08.2022.
//

import UIKit

final class DetailSettingView: UIView {
    
    private var onBackButton: (()->())?

    public var tableView: UITableView!
    
    private let indent: CGFloat = 20
    
    private let rightIndent: CGFloat = 15
        
    private lazy var backButton = UIButton()
        .setMyStyle(backgroundColor: .white)
        .setShadow()
        .addImage(image: Image.cancel)
        .setTarget(method: #selector(backButtonAction),
                   target: self,
                   event: .touchUpInside)

    private func configureTableView() {
        tableView = UITableView.init(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.mainBackgroundColor
        tableView.isScrollEnabled = false
        tableView.allowsMultipleSelection = false
        tableView.separatorStyle = .none
        self.addSubview(tableView)
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackgroundColor
        configureTableView()
        setupViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarhies() {
        self.addSubview(backButton)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: indent),
            backButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -rightIndent)
        ])

        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: indent)
        ])
    }
    
    @objc func backButtonAction() {
        onBackButton?()
    }
}
//MARK: Extension
extension DetailSettingView: ConfigurableView {
    
    typealias Model = ModelDetailSettingView
    
    func configure(with model: ModelDetailSettingView) {
        self.onBackButton = model.onBackButton
    }
}
