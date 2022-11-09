//
//  SettingView.swift
//  Quiz Game
//
//  Created by APPLE on 11.07.2022.
//

import UIKit

final class SettingView: UIView {
    
    //MARK: Properties
    private var onClosedButton: (()->())?
    
    public var tableView: UITableView!
    
    private let indent: CGFloat = 20
    
    private let indentFromTop: CGFloat = 40

    private lazy var backButton = UIButton()
        .setMyStyle(backgroundColor: .white)
        .addImage(image: Image.backButton)
        .setTarget(method: #selector(closedButtonAction),
                   target: self,
                   event: .touchUpInside)
    
    private func configureTableView() {
        tableView = UITableView.init(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.mainBackgroundColor
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        self.addSubview(tableView)
    }
    
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
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: indentFromTop)
        ])
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: indent),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: indent)
        ])
    }
    
    @objc func closedButtonAction() {
        onClosedButton?()
    }
}
//MARK: Extension
extension SettingView: ConfigurableView {
    
    typealias Model = ModelSettingView
    
    func configure(with model: ModelSettingView) {
        self.onClosedButton = model.onClosedButton
    }
}
