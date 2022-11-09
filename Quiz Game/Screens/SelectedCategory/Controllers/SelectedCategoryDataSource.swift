//
//  SelectedCategoryDataSource.swift
//  Quiz Game
//
//  Created by USER on 26.10.2022.
//

import UIKit

protocol SelectedCategoryDataSourceOutput: AnyObject {
    func updateCategory(category: CategoryType)
}

final class SelectedCategoryDataSource: NSObject {
    
    public let model: ModelSelectedCategory
    
    weak var output: SelectedCategoryDataSourceOutput?
    
    private var categoryTypes: [[CategoryType]] {
        return mapCategoryType(model: model.categories)
    }

    private var models: [[ModelSelectedCategoryCell]] {
        return map(model: categoryTypes)
    }
    
    private var lastSelectedIndexPath: IndexPath!

    init(model: ModelSelectedCategory) {
        self.model = model
    }
    
    private func mapCategoryType(model: [Category]) -> [[CategoryType]] {
        model.map { category in
            if var categoryTypes = category.categoryType?.allObjects as? [CategoryType] {
                categoryTypes.sort(by: { $0.name < $1.name })
                return categoryTypes
            }
            return [CategoryType]()
        }
    }
    
    private func map(model: [[CategoryType]]) -> [[ModelSelectedCategoryCell]] {
        model.map { categoryTypes in
            return categoryTypes.map { categoryType in
                ModelSelectedCategoryCell(
                    nameType: categoryType.name,
                    countQuestion: categoryType.question.count,
                    state: categoryType.progressCategoryType)
            }
        }
    }
}
//MARK: Extension
extension SelectedCategoryDataSource: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifire, for: indexPath) as? CategoryCell else { return UITableViewCell() }
        
        if indexPath.section < models.count {
            cell.configure(with: models[indexPath.section][indexPath.row])
            
            cell.setSeparator(
                indexPath: indexPath,
                count: models[indexPath.section].count)
            
            if model.currentСategory.category.name == models[indexPath.section][indexPath.row].nameType {
                cell.isSelected = true
                lastSelectedIndexPath = indexPath
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SelectedCategoryHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.configureView(header: model.categories[section].name)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: model.settingSound)
     
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryCell else { return }
        cell.selectionStyle = .default

        output?.updateCategory(category: categoryTypes[indexPath.section][indexPath.row])
        
        cell.isSelected = true
        
        guard let cellSelected = tableView.cellForRow(at: lastSelectedIndexPath) as? CategoryCell else { return }

        cellSelected.isSelected = false
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        lastSelectedIndexPath = indexPath
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let myCell = cell as? CategoryCell else { return }

        let categoryType = categoryTypes[indexPath.section][indexPath.row]
        
        if model.currentСategory.category.name == categoryType.name {
            cell.isSelected = true
        }

        myCell.setCornerRadius(
            indexPath: indexPath,
            count: tableView.numberOfRows(inSection: indexPath.section))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
