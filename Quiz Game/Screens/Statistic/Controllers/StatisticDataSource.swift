//
//  StatisticDataSource.swift
//  Quiz Game
//
//  Created by USER on 26.10.2022.
//

import UIKit

protocol StatisticDataSourceOutput: AnyObject {
    
    func deleteOneGame(index: Int)
    
    func deleteAllMyGame()
    
    func transition(index: Int)
}

final class StatisticDataSource: NSObject {
    
    weak var output: StatisticDataSourceOutput?
    
    public var model: ModelStatistic
    
    private var models: [ModelStatisticCell] {
          return map(model: model.historyGame)
    }
    
    init(model: ModelStatistic) {
        self.model = model
    }
    
    private func map(model: [ActualQuizSession]) -> [ModelStatisticCell] {
        
        model.map { historyGame in
            ModelStatisticCell(
                nameGame: historyGame.categoryType.name,
                progress: historyGame.progressForGame,
                dateGame: Date())
        }
    }
}

//MARK: Extension
extension StatisticDataSource: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryGameCell.identifire, for: indexPath) as? HistoryGameCell else { return UITableViewCell() }
        
        if indexPath.row < models.count {
            cell.configure(with: models[indexPath.row])
            cell.setSeparator(indexPath: indexPath, lastCell: models.count)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = SecondHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))

        view.configure(with: SecondHeaderView.Model(
            onAction: { [weak self] in
                self?.model.historyGame.removeAll()
                self?.output?.deleteAllMyGame()
            }))
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: model.settingSound)
        
        output?.transition(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let myCell = cell as? HistoryGameCell else {return}
        
        myCell.setCornerRadius(
            indexPath: indexPath,
            lastCell: tableView.numberOfRows(inSection: indexPath.section))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
            
        case .delete:
            model.historyGame.remove(at: indexPath.row)
            output?.deleteOneGame(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
        tableView.reloadData()
    }
}
