//
//  SettingViewController.swift
//  Quiz Game
//
//  Created by APPLE on 11.07.2022.
//

import UIKit

enum Cell: Int {
    case sound
    case noCorrectAnswer
    case afterHelp
    case randomQuestion
}

final class SettingViewController: UIViewController {
    
    //MARK: Properties
    fileprivate var settingView: SettingView {
        guard let view = self.view as? SettingView else {return SettingView()}
        return view
    }
    
    private var settingGame: ModelSetting? {
        didSet {
            models = createModelForCell()
        }
    }
    
    private var models: [ModelSettingCell] = []
    
    private lazy var soundSwitch: UISwitch = {
        let mySwitch = UISwitch(frame: .zero)
        mySwitch.addTarget(self, action: #selector(soundButtonAction), for: .allEvents)
        return mySwitch
    }()
    
    private lazy var randomQuestion: UISwitch = {
        let mySwitch = UISwitch(frame: .zero)
        mySwitch.addTarget(self, action: #selector(randomQuestionButtonAction), for: .allEvents)
        return mySwitch
    }()
    
    private var stateAfterHelp: String {
        guard let settingGame = settingGame else { return "" }
        if settingGame.afterHelp.state {
            return "On"
        } else {
            return "Off"
        }
    }
    
    private var stateIfWrongAnswer: String {
        guard let settingGame = settingGame else { return "" }
        if settingGame.transitionAfterHelp.state {
            return "On"
        } else {
            return "Off"
        }
    }
    
    public var dataSource: SelectViewControllerDataSourse? {
        didSet {
            guard let dataSource = dataSource else {return}
            self.settingGame = dataSource.featchSettingGame()
        }
    }
        
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = SettingView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        dataSource?.updateSettingsGame(setting: settingGame)
    }
    
    private func createModelForCell() -> [ModelSettingCell] {
        guard let settingGame = self.settingGame else { return []}
        
        let sound = ModelSettingCell(titleLabel: "Sounds", logoImage: Image.soudsGame, detailText: nil)
        
        let noCorrectAnswer = ModelSettingCell(
            titleLabel: settingGame.afterHelp.name,
            logoImage: Image.afterHelp,
            detailText: stateAfterHelp)
        
        let afterHelp = ModelSettingCell(
            titleLabel: settingGame.transitionAfterHelp.name,
            logoImage: Image.transitionAfterHelp,
            detailText: stateIfWrongAnswer)
        
        let randomQuestion = ModelSettingCell(titleLabel: "Random Question", logoImage: Image.randomQuestion, detailText: nil)
     
        return [sound, noCorrectAnswer, afterHelp, randomQuestion]
    }
    
    private func setupTableView() {
        settingView.tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifire)
  
        settingView.tableView.dataSource = self
        settingView.tableView.delegate = self
    }
    
    private func setView() {
        settingView.configure(with: ModelSettingView(
            onClosedButton: {[weak self] in
                self?.closedButtonAction()
            }))
    }
    
    private func closedButtonAction() {
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: settingGame?.sounds)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func soundButtonAction(sender: UISwitch) {
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: sender.isOn)
        self.settingGame?.sounds = sender.isOn
    }
    
    @objc func randomQuestionButtonAction(sender: UISwitch) {
        self.settingGame?.randomQuestion = sender.isOn
    }
}
//MARK: Extension
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifire, for: indexPath) as? SettingCell else {return UITableViewCell()}
                
        let cellEnum = Cell(rawValue: indexPath.row)
        
        guard let settingGame = self.settingGame else {return cell}
        
        switch cellEnum {
            
        case .sound:
            soundSwitch.setOn(settingGame.sounds, animated: settingGame.sounds)
            cell.configure(with: models[indexPath.row])

            cell.selectionStyle = .none
            cell.accessoryView = soundSwitch
            
        case .noCorrectAnswer:
            cell.configure(with: models[indexPath.row])
            cell.accessoryType = .disclosureIndicator
            
        case .afterHelp:
            cell.configure(with: models[indexPath.row])
            cell.accessoryType = .disclosureIndicator
            
        case .randomQuestion:
            randomQuestion.setOn(settingGame.randomQuestion, animated: settingGame.randomQuestion)
            
            cell.configure(with: models[indexPath.row])
            cell.accessoryView = randomQuestion
            cell.selectionStyle = .none
            
        case .none:
            break
        }
        
        cell.setup(
            hideTopSeparator: indexPath.row == 0,
            hideBotSeparator: indexPath.row == 3)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let settingGame = settingGame else { return }
      
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: settingGame.sounds)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellEnum = Cell(rawValue: indexPath.row)
        switch cellEnum {
            
        case.sound:  break
        
        case .noCorrectAnswer:
            let detailSettingVC = DetailSettingViewController(
                model: ModelAfterHelp(
                    afterHelp: settingGame.afterHelp,
                    sounds: settingGame.sounds))
            
            navigationController?.present(detailSettingVC, animated: true)
            detailSettingVC.feachState = { model in
                self.settingGame?.afterHelp = model
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        case .afterHelp:
            let detailSettingVC = DetailSettingViewController(
                model: ModelAfterHelp(
                    afterHelp: settingGame.transitionAfterHelp,
                    sounds: settingGame.sounds))
            
            navigationController?.present(detailSettingVC, animated: true)
            detailSettingVC.feachState = { model in
                self.settingGame?.transitionAfterHelp = model
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        case .randomQuestion: break
            
        case .none:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        45
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let myCell = cell as? SettingCell else {return}

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
        65
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        view.configureView(title: "Setting")
        return view
    }
}
