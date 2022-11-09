//
//  DetailSettingViewController.swift
//  Quiz Game
//
//  Created by USER on 11.08.2022.
//

import UIKit

enum CellDetailSetting: Int {
    case On
    case Off
}

final class DetailSettingViewController: UIViewController {
    
    //MARK: Properties
    fileprivate var detailSettingView: DetailSettingView {
        guard let view = self.view as? DetailSettingView else {return DetailSettingView()}
        return view
    }
    
    public var feachState: ((ModelSettingGame)->())?
    
    private var lastSelectedIndexPath: IndexPath!
    
    private var model: ModelAfterHelp
    
    //MARK: Init
    init(model: ModelAfterHelp) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = DetailSettingView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailSettingView.tableView.register(DetailSettingCell.self, forCellReuseIdentifier: DetailSettingCell.identifire)
        
        detailSettingView.tableView.dataSource = self
        detailSettingView.tableView.delegate = self
        
        detailSettingView.configure(with: ModelDetailSettingView(
            onBackButton: {[weak self] in
                self?.backButton()
            }))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func backButton() {
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: model.sounds)
        dismiss(animated: true)
    }
}
//MARK: Extension
extension DetailSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.afterHelp.selectedState.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailSettingCell.identifire, for: indexPath) as? DetailSettingCell else {return UITableViewCell()}
        
        let cellEnum = CellDetailSetting(rawValue: indexPath.row)
        
        let data = model.afterHelp.selectedState[indexPath.row]
        
        if  data.isSelected {
            cell.accessoryType = .checkmark
            cell.isSelected = true
            lastSelectedIndexPath = indexPath
        }

        switch cellEnum {
        case .On:
            cell.configure(with: ModelDetailSettingCell(
                state: data.nameRezult))
            
        case .Off:
            cell.configure(with: ModelDetailSettingCell(
                state: data.nameRezult))
            
        case .none:
            break
        }
        
        cell.setup(
            hideTopSeparator: indexPath.row == 0,
            hideBotSeparator: indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: model.sounds)
        
       guard let cell = tableView.cellForRow(at: indexPath) as? DetailSettingCell else {return}
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let arrayIsSelected = model.afterHelp.selectedState[indexPath.row].isSelected
        
        guard arrayIsSelected == false else {return}
        cell.accessoryType = .checkmark
        
        model.afterHelp.selectedState[indexPath.row].isSelected = true
        
        let cellSelected = tableView.cellForRow(at: lastSelectedIndexPath)
        
        cellSelected?.accessoryType = .none
        
        model.afterHelp.selectedState[lastSelectedIndexPath.row].isSelected = false
        
        lastSelectedIndexPath = indexPath
        
        let rezult = model.afterHelp.selectedState[indexPath.row].nameRezult
        
        if rezult == "On"{
            model.afterHelp.state = true
        } else {
            model.afterHelp.state = false
        }
        
        feachState?(model.afterHelp)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let myCell = cell as? DetailSettingCell else {return}

        if (indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1) {
            myCell.fullCornerRadiusCell = true
            
        } else if (indexPath.row == 0) {
            myCell.topCell = true
        }
        
        else if (indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1) {
            myCell.bottomCell = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DetailHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.configureView(title: model.afterHelp.header)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = DetailFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.configureView(title: model.afterHelp.description)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        45
    }
}
