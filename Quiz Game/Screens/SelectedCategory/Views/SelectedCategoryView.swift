//
//  SelectedCategoryView.swift
//  Quiz Game
//
//  Created by APPLE on 10.07.2022.
//

import UIKit

final class SelectedCategoryView: UIView {
    
    //MARK: Properties
    private var onBackButton: (()->())?
    
    public var tableView: UITableView!
    
    private func configureTableView() {
        tableView = UITableView.init(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor =  .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .singleLine
        tableView.allowsMultipleSelection = false
    }

    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackgroundColor
        configureTableView()
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(tableView)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.92),
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc func backButtonAction() {
        onBackButton?()
    }
}
//MARK: Extension
extension SelectedCategoryView: ConfigurableView {
    typealias Model = ModelSelectedCategoryView
    
    func configure(with model: Model) {
        self.onBackButton = model.onBackButton
    }
}
