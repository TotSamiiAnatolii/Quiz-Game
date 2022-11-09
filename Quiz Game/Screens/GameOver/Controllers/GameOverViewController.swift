//
//  GameOverViewController.swift
//  Quiz Game
//
//  Created by APPLE on 08.07.2022.
//

import UIKit

final class GameOverViewController: UIViewController {
    
    //MARK: Properties
    fileprivate var viewGameOver: GameOverView {
        guard let view = self.view as? GameOverView else {return GameOverView()}
        return view
    }
    
    private var timer: Timer?
    
    private var count: Float = 0
    
    private var model: ModelGameOver?
    
    private var delegate: GameOverDelegate?
    
    private var timeInterval: TimeInterval {
        guard let progress = model?.progressGame else {return TimeInterval()}
        return TimeInterval((1 / progress))
    }
    
    //MARK: Init
    init(model: ModelGameOver) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = GameOverView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewGameOver.configure(with: ModelGameOverView(
            onAction: { [weak self] type in
                self?.buttonActions(type: type)
            }))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let model = model else {return}
        viewGameOver.progressBar(toValue: model.progressGame / 100)
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(workWithTimer), userInfo: nil, repeats: true)
    }
    
    @objc func workWithTimer() {
        guard let progress = model?.progressGame else {return}
        
        if count < progress {
            count += 1
            
            viewGameOver.configureGameOverView(correct: Float(count))
        } else {
            timer?.invalidate()
            
            showRezult(rezult: model?.progressGame)
        }
    }
    
    private func buttonActions(type: ButtonType) {
        switch type {
        case .repeatGame:
            repeatGame()
        case .finish:
            gameOver()
        case .start:
            break
        case .selected:
            break
        case .statistic:
            break
        case .setting:
            break
        }
    }
    
    private func showRezult(rezult: Float?) {
        guard let rezult = rezult else {return}
        
        switch rezult {
        case 0:
            viewGameOver.configureRezulLabel(rezult: "Ужасно")
        case 0..<20:
            viewGameOver.configureRezulLabel(rezult: "Плохо")
        case 20..<40:
            viewGameOver.configureRezulLabel(rezult: "Средний результат")
        case 40...70:
            viewGameOver.configureRezulLabel(rezult: "Нормально")
        case 70...100:
            viewGameOver.configureRezulLabel(rezult: "Хорошо")
            
        default:
            break
        }
    }
    
    //MARK: Buttons actions
    private func repeatGame() {
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: model?.settingSound)
        navigationController?.popViewController(animated: true)
    }
    
    private func gameOver() {
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: model?.settingSound)
        navigationController?.popToRootViewController(animated: true)
    }
}
