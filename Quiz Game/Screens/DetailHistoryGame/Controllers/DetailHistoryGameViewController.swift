//
//  DetailHistoryGameViewController.swift
//  Quiz Game
//
//  Created by APPLE on 08.09.2022.
//

import UIKit

final class DetailHistoryGameViewController: UIViewController {
    
    //MARK: Properties
    fileprivate var detailHistoryGame: DetailHistoryGameView {
        guard let view = self.view as? DetailHistoryGameView else {return DetailHistoryGameView()}
        return view
    }
    
    private var containerView = DetailsGameHeaderView()
    
    private let dataSourse: DetailHistoryGameDataSource
        
    //MARK: Init
    init(model: ModelDetailStatistic) {
        self.dataSourse = DetailHistoryGameDataSource(model: model)
        super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = DetailHistoryGameView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourse.output = self
        
        containerView.frame = CGRect(x: 0, y: 0, width: detailHistoryGame.tableView.frame.width, height: 150)
        
        setupTableView()
        setMainView()
        setHeaderView()
    }
    
    private func setupTableView() {
        detailHistoryGame.tableView.delegate = dataSourse
        detailHistoryGame.tableView.dataSource = dataSourse
        
        detailHistoryGame.tableView.estimatedRowHeight = 300
        detailHistoryGame.tableView.rowHeight = UITableView.automaticDimension
        
        detailHistoryGame.tableView.register(DetailHistoryGameCell.self, forCellReuseIdentifier: DetailHistoryGameCell.identifire)
        
        detailHistoryGame.tableView.tableHeaderView = containerView
        detailHistoryGame.tableView.separatorStyle = .none
    }
    
    private func setHeaderView() {
        containerView.configure(with: DetailsGameHeaderView.Model(
            help: dataSourse.viewModel.helpCount,
            numberOfQuestions: dataSourse.viewModel.categoryType.question.count,
            correctAnswers: dataSourse.viewModel.correctAnswersCount))
    }
    
    private func setMainView() {
        detailHistoryGame.configure(with: DetailHistoryGameView.Model(
            onBackButton: {[weak self] in
                self?.backButtonAction()
            }))
    }
    
    private func backButtonAction() {
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: dataSourse.model.settingSound)
        dismiss(animated: true)
    }
    
    private func showHelpButton(help: String) {
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: false)

        detailHistoryGame.helpPopUpView.configure(with: ModelHelpPopUpView(
            onReturnGameAction: {[weak self] in
                self?.hideHelpButton()
            },
            textHelp: help))
        
        view.addSubview(detailHistoryGame.helpPopUpView)
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseIn) {
            self.detailHistoryGame.helpPopUpView.alpha = 1
        }
    }
    
    private func hideHelpButton() {
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: dataSourse.model.settingSound)
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
            self.detailHistoryGame.helpPopUpView.alpha = 0
            
        }, completion: { _ in
            self.detailHistoryGame.helpPopUpView.removeFromSuperview()
        })
    }
}
extension DetailHistoryGameViewController: DetailHistoryGameDataSourceOutput {
    func didSelect(help: String) {
        showHelpButton(help: help)
    }
}

