//
//  StartViewController.swift
//  Quiz Game
//
//  Created by APPLE on 08.07.2022.
//

import UIKit

final class MainViewController: UIViewController {
     
    //MARK: Properties
    fileprivate var mainView: MainView {
        guard let view = self.view as? MainView else {return MainView()}
        return view }
        
    private var historyGame: [ActualQuizSession] = []
    
    private var question: [Category] = []
        
    private var settingForGame: ModelSetting?
    
    private var currentCategory: CategoryForGame?
            
    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDateFromStorage()
        fetchDateActualSession()
        featchUserSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavigationBar()
        
        mainView.configure(with: MainView.Model(
            onAction: { [weak self] type in
                self?.buttonActions(type: type)
            },
            currentCategory: currentCategory?.category.name ?? "Error"))
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func fetchDateFromStorage() {
        question = CoreDataManager.shared.receiveNotes()
    }

    private func fetchDateActualSession() {
        currentCategory = CoreDataManager.shared.receiveCategorForGame().first
        historyGame = CoreDataManager.shared.receiveActualQuizSession()
    }
    
    private func featchUserSettings() {
        self.settingForGame = UserDefaultsManager.shared.featchUserSetting()
    }
    
    private func buttonActions(type: ButtonType) {
        switch type {
        case .start:
            startButtonAction()
        case .selected:
            selectedCategoryButtonAction()
        case .statistic:
            statisticAction()
        case .setting:
            settingButtonAction()
        case .repeatGame:
            break
        case .finish:
            break
        }
    }
 
    private func statisticAction() {
        guard let settingForGame = settingForGame else { return }

        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: settingForGame.sounds)
                
        let statisticVC = StatisticViewController(model: ModelStatistic(
            settingSound: settingForGame.sounds,
            categoryType: question,
            historyGame: historyGame))

        statisticVC.delegate = self
        self.navigationController?.pushViewController(statisticVC, animated: true)
    }
    
    private func startButtonAction() {
        guard let settingForGame = settingForGame else { return }

        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: settingForGame.sounds)
        
        guard let categoryForGame = currentCategory else {return}
        
        let mainVC = GameViewController(model: ModelGame(
            categoryForGame: categoryForGame.category,
            settingForGame: settingForGame))
        
        mainVC.delegate = self
        
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    private func selectedCategoryButtonAction() {
        guard let settingForGame = settingForGame else { return }
        
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: settingForGame.sounds)
                
        guard let categoryForGame = currentCategory else {return}
        
        let selectedCategoryVC = SelectedCategoryViewController(model: ModelSelectedCategory(
            categories: question,
            settingSound: settingForGame.sounds,
            currentСategory: categoryForGame))
        
        selectedCategoryVC.delegate = self
        
        self.navigationController?.pushViewController(selectedCategoryVC, animated: true)
    }
    
    private func settingButtonAction() {

        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: settingForGame?.sounds)
        
        let settingVC = SettingViewController()
        settingVC.dataSource = self

            self.navigationController?.pushViewController(settingVC, animated: true)
        }
    }

extension MainViewController: SelectViewControllerDataSourse, GameOverDelegate, StatisticDelegate {
  
    func updateSettingsGame(setting model: ModelSetting?) {
        guard let model = model else { return }
        self.settingForGame = model
        UserDefaultsManager.shared.saveUserSetting(data: model)
    }
   
    func featchSettingGame() -> ModelSetting {
        self.settingForGame!
    }
    
    func featchRezultGame(session: ActualQuizSession) {
        self.historyGame.insert(session, at: 0)
    }

    func updateCurrentCategory(category: CategoryType) {
        self.currentCategory?.category = category
        CoreDataManager.shared.save()
    }
    
    func deleteOneCategoryProgress(index: Int) {
        CoreDataManager.shared.deleteActualSession(session: historyGame[index])
        self.historyGame.remove(at: index)
    }
    
    func deleteAllCategoryProgress() {
        self.historyGame.forEach { session in
            CoreDataManager.shared.deleteActualSession(session: session)
        }
        historyGame.removeAll()
    }
}
