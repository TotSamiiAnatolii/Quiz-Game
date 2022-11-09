//
//  DetailHistoryGameDataSource.swift
//  Quiz Game
//
//  Created by APPLE on 25.10.2022.
//

import UIKit

protocol DetailHistoryGameDataSourceOutput: AnyObject {
    func didSelect(help: String)
}

final class DetailHistoryGameDataSource: NSObject {
    
    weak var output: DetailHistoryGameDataSourceOutput?
    
    public let model: ModelDetailStatistic
    
    private var models: [ModelDetailStatisticCell] {
        map(model: model)
    }
    
    public var viewModel: ActualQuizSession {
        return model.categoryGame
    }
    
    init(model: ModelDetailStatistic) {
        self.model = model
    }
    
    public func map(model: ModelDetailStatistic) -> [ModelDetailStatisticCell] {
        
        guard let question = model.categoryGame.actualAnswers?.allObjects as? [ActualQuestion] else {return  [ModelDetailStatisticCell]()}
        
        return  question.map { question in
            ModelDetailStatisticCell(
                onAction: {[weak self] in
                    
                    self?.output?.didSelect(help: question.question.help)
                },
                textQuestion: question.question.textQuestion,
                myAnswer: question.myAnswer,
                isAnswer: question.isAnswered,
                photoQuestion: UIImage(data: question.question.photoQuestion ?? Data()))
        }
    }
}
//MARK: Extension
extension DetailHistoryGameDataSource: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailHistoryGameCell.identifire, for: indexPath) as? DetailHistoryGameCell else {return UITableViewCell()}
    
        if indexPath.row < models.count {
            let model = models[indexPath.row]
            cell.configure(with: model)
            cell.setSeparator(indexPath: indexPath, count: models.count)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DetailGameSecondHeaderVIew(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.configure(with: DetailGameSecondHeaderVIew.Model())
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let myCell = cell as? DetailHistoryGameCell else {return}
        
        myCell.setCornerRadius(indexPath: indexPath, count: models.count)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

