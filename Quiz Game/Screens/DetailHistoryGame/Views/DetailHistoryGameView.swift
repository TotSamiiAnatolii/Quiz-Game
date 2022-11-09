//
//  DetailHistoryGameView.swift
//  Quiz Game
//
//  Created by APPLE on 08.09.2022.
//

import UIKit

final class DetailHistoryGameView: UIView {
    
    //MARK: Properties
    private var onBackButton: (()->())?
    
    public var tableView = UITableView()
    
    private let topIndent: CGFloat = 15
    
    private let rightIndent: CGFloat = 15
    
    private let indent: CGFloat = 20
    
    public let helpPopUpView: HelpPopupView = {
        let view = HelpPopupView()
        view.alpha = 0
        return view
    }()
    
    private lazy var backButton = UIButton()
        .setMyStyle(backgroundColor: .white)
        .addImage(image: Image.cancel)
        .setTarget(method: #selector(backButtonAction),
                   target: self,
                   event: .touchUpInside)
    
    private func configureTableView() {
        tableView = UITableView.init(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.mainBackgroundColor
        tableView.showsVerticalScrollIndicator = false
        self.addSubview(tableView)
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackgroundColor
        setupViewHierarhies()
        configureTableView()
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
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: topIndent),
            backButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -rightIndent)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: topIndent),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: indent),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -indent)
        ])
    }
    
    @objc func backButtonAction() {
        onBackButton?()
    }
}
//MARK: Extension
extension DetailHistoryGameView: ConfigurableView {
    
    typealias Model = ModelDetailStatisticView
    
    func configure(with model: Model) {
        self.onBackButton = model.onBackButton
    }
}
