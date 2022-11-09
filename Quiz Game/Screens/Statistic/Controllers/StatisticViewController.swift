//
//  StatisticViewController.swift
//  Quiz Game
//
//  Created by APPLE on 12.07.2022.
//

import UIKit

final class StatisticViewController: UIViewController {
    
    //MARK: Properties
    fileprivate var statisticView: StatisticView {
        guard let view = self.view as? StatisticView else {return StatisticView()}
        return view
    }
    
    private let header = "Statistic"
        
    private let dataSource: StatisticDataSource
    
    private lazy var containerView = MainHeaderView()
    
    public var delegate: StatisticDelegate?
    
    //MARK: Init
    init(model: ModelStatistic) {
        self.dataSource = StatisticDataSource(model: model)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = StatisticView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = header
        dataSource.output = self
        setupTableView()
        setupNavigationBar()
        configurableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.motionGeoTag()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: dataSource.model.settingSound)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        containerView.frame = CGRect(x: 0, y: 0, width: statisticView.tableView.frame.width, height: 220)
    }
    
    private func configurableView() {
        containerView.configure(with: MainHeaderView.Model(
            statisticLabel: dataSource.model.historyGame.count,
            progressLabel: dataSource.model.categoryComplMastered))
    }
    
    private func setupTableView() {
        statisticView.tableView.delegate = dataSource
        statisticView.tableView.dataSource = dataSource
        statisticView.tableView.register(HistoryGameCell.self, forCellReuseIdentifier: HistoryGameCell.identifire)
        statisticView.tableView.tableHeaderView = containerView
        statisticView.tableView.separatorStyle = .none
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Colors.mainBackgroundColor
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.compactAppearance = appearance
    }
    
    private func motionGeoTag() {
        containerView.animationGeoTag(progress: dataSource.model.categoryComplMastered / 100)
    }
}

extension StatisticViewController: StatisticDataSourceOutput {
    
    func transition(index: Int) {
        let detailsGameVC = DetailHistoryGameViewController(model: ModelDetailStatistic(
            categoryGame: dataSource.model.historyGame[index],
            settingSound: dataSource.model.settingSound))
        self.navigationController?.present(detailsGameVC, animated: true)
    }
    
    func deleteAllMyGame() {
        delegate?.deleteAllCategoryProgress()
        motionGeoTag()
        configurableView()
        statisticView.tableView.reloadData()
    }
    
    func deleteOneGame(index: Int) {
        delegate?.deleteOneCategoryProgress(index: index)
        motionGeoTag()
        configurableView()
    }
}
