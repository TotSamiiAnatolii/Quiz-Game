//
//  StatisticView.swift
//  Quiz Game
//
//  Created by APPLE on 12.07.2022.
//

import UIKit

final class StatisticView: UIView {
        
    //MARK: Properties
    public var tableView: UITableView!

    private func configureTableView() {
        tableView = UITableView.init(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.mainBackgroundColor
        tableView.showsVerticalScrollIndicator = false
        self.addSubview(tableView)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackgroundColor
        configureTableView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.92),
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
