//
//  ViewController.swift
//  Quiz Game
//
//  Created by APPLE on 08.08.2022.
//

import UIKit

final class GameViewController: UIViewController, LogicForGame {
    
    //MARK: Properties
    fileprivate var gameView: GameView {
        guard let view = self.view as? GameView else {return GameView()}
        return view
    }
    
    private var progress: Float = 0
    
    private var answerCorrect: String = ""
    
    private var model: ModelGame?
    
    public var delegate: GameOverDelegate?
    
    private var actualSession: ActualQuizSession?
    
    private var actualAnswerArray: [ActualQuestion] = []
    
    private  var amountQuestion: Int  {
        guard let model = model else { return 0 }
        
        return model.categoryForGame.question.count
    }
    
    private var progresCount: Float {
        guard let model = model else { return 0 }
        
        let fullProgress: Float = 1
        
        let countQuestion = Float(model.categoryForGame.question.count)
        
        return fullProgress / countQuestion
    }
    
    private var currentQuestion: Int = 1 {
        didSet {
            gameView.configure(with: GameView.Model(
                onBackAction: {[weak self] in
                    self?.backButtonAction()
                },
                onHelpAction: {[weak self] in
                    self?.showHelpButton()
                },
                progres: progress,
                currentQuestion: currentQuestion,
                countQuestion: amountQuestion))
        }
    }
    
    private var correctAnswerCount: Int = 0
    
    //MARK: Init
    init(model: ModelGame) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = GameView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        gameView.containerView.delegate = self
        
        gameView.configure(with: GameView.Model(
            onBackAction: {[weak self] in
                self?.backButtonAction()
            },
            onHelpAction: {[weak self] in
                self?.showHelpButton()
            },
            progres: progress,
            currentQuestion: currentQuestion,
            countQuestion: amountQuestion))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        actualAnswerArray.removeAll()
        actualSession = ActualQuizSession(context: CoreDataManager.shared.viewContext)
        gameView.containerView.dataSource = self
        startNewGame()
    }
    
    private func backButtonAction() {
        guard let actualSession = actualSession else {
            return
        }

        CoreDataManager.shared.deleteActualSession(session: actualSession)
        guard let model = model else {return}
        
        gameView.containerView.dataSource = nil
        gameView.containerView.delegate = nil
        
        soundsGame(model: model.settingForGame,
                   sound: SoundPlayer.shared.tapButtonSound)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func saveActionQuizSession() {
        guard let model = self.model else {return}
        actualSession?.categoryType = model.categoryForGame
        actualSession?.actualAnswers = NSSet(array: actualAnswerArray)
        actualSession?.startDate = Date()
        CoreDataManager.shared.save()
    }
    
    private func startNewGame() {
        self.progress = 0
        self.currentQuestion = 1
    }
    
    private func showHelpButton() {
        
        guard let help = model?.categoryForGame.question.allObjects as? [Question] else { return }
        
        actualSession?.helpCount += 1
        
        guard let settingForGame = model?.settingForGame else { return }
        
        soundsGame(model: settingForGame,
                   sound: SoundPlayer.shared.tapButtonSound)
        
        let currentIndexQuestion = currentQuestion - 1
        
        gameView.helpPopUpView.configure(with: ModelHelpPopUpView(
            onReturnGameAction: { [weak self] in
                self?.hideHelpButton()
            },
            textHelp: help[currentIndexQuestion].help))
        
        self.view.addSubview(gameView.helpPopUpView)
        
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            options: .curveEaseIn) { [weak self]  in
                self?.gameView.helpPopUpView.alpha = 1
            }
    }
    
    private func hideHelpButton() {
        guard let model = model else { return }
        
        soundsGame(model: model.settingForGame,
                   sound: SoundPlayer.shared.tapButtonSound)
        
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            options: .curveEaseIn,
            animations: {
                
                self.gameView.helpPopUpView.alpha = 0
                
            }, completion: { [weak self] _ in
                
                self?.gameView.helpPopUpView.removeFromSuperview()
                
                self?.transitionAfterHelp(
                    model: model.settingForGame)
            })
    }
    
    private func createActualQuestion(isAnswer: Bool, answer: String) {
        
        guard let question = model?.categoryForGame.question.allObjects as? [Question] else { return }
        
        let currentIndexQuestion = currentQuestion - 1
        
        let actualQuestion = ActualQuestion(context: CoreDataManager.shared.viewContext)
        actualQuestion.myAnswer = answer
        actualQuestion.date = Date()
        actualQuestion.isAnswered = isAnswer
        actualQuestion.question = question[currentIndexQuestion]
        
        actualAnswerArray.append(actualQuestion)
    }
    
    func userChoseAnswer(sender: UIButton, card: QuestionView) {
        
        guard let model = model else { return }
        
        guard let answerLable = sender.titleLabel?.text?.fetchString() else { return }
        
        if  answerLable == answerCorrect {
            
            soundsGame(model: model.settingForGame,
                       sound: SoundPlayer.shared.answerTrueSound)

            sender.isSelected = true
            card.selectedAnswerButton(sender: sender)
            deleteCard(rezultAnswer: true, answer: answerLable)
            
        } else {
            
            soundsGame(model: model.settingForGame,
                       sound: SoundPlayer.shared.answerFalseSound)
            sender.isSelected = false
            card.selectedAnswerButton(sender: sender)
            afterNoCorrectAnswer(
                model: model.settingForGame,
                rezultAnswer: false,
                myAnswer: answerLable)
        }
    }
    
    func deleteCard(rezultAnswer: Bool, answer: String) {
        gameView.containerView.deleteCard(bool: rezultAnswer)

        createActualQuestion(isAnswer: rezultAnswer, answer: answer)
    }
    
    func afterNoCorrectAnswer(model: ModelSetting, rezultAnswer: Bool, myAnswer: String) {
        if model.afterHelp.state {
            if rezultAnswer == false {
                showHelpButton()
            } else {
                self.deleteCard(rezultAnswer: rezultAnswer, answer: myAnswer)
            }
        } else {
            self.deleteCard(rezultAnswer: rezultAnswer, answer: myAnswer)
        }
    }
    
    func transitionAfterHelp(model: ModelSetting) {
        
        if model.transitionAfterHelp.state {
            
            let myAnswer = "Нет ответа"
            
            let responseResult = false
            
            deleteCard(rezultAnswer: responseResult, answer: myAnswer)
        }
    }
    
    func soundsGame(model: ModelSetting, sound: URL) {
        SoundPlayer.shared.setButtonTapSound(sound: sound,
                                             setting: model.sounds)
    }
    
    func randomQuestion(model: ModelSetting) {
        print("Вопросы случайным образом")
    }
}

//MARK: Extension
extension GameViewController: ContainerQuestionViewDataSource, ContainerQuestionViewDelegate {
    
    func containerView(answer: UIButton, view: QuestionView) {
        guard let question = model?.categoryForGame.question.allObjects as? [Question] else { return }
        
        let currentIndexQuestion = currentQuestion - 1
        answerCorrect = question[currentIndexQuestion].answerCorrect
        userChoseAnswer(sender: answer, card: view)
    }
    
    func numberOfQuestionToShow() -> Int {
        guard let model = model else { return 0 }
        
        return model.categoryForGame.question.count
    }
    
    func containerView(createQuestionView index: Int) -> QuestionView {
        guard let question = model?.categoryForGame.question.allObjects as? [Question] else { return QuestionView() }
        
        let questionModel = question[index]
        let card = QuestionView()
        
        card.configure(with: QuestionView.Model (
            question: questionModel.textQuestion,
            photoQuestion: UIImage(data: questionModel.photoQuestion ?? Data()) ,
            answer: questionModel.answer
        ))
        
        return card
    }
    
    func questionCounting(correctAnswer: Bool) {
        guard let model = model else { return }
        
        guard let question = model.categoryForGame.question.allObjects as? [Question] else { return }
        
        if question.count > currentQuestion {
            if correctAnswer {
                self.correctAnswerCount += 1
            }
            progress += progresCount
            currentQuestion += 1
            
        } else {
            
            if correctAnswer {
                self.correctAnswerCount += 1
                progress += progresCount
            }
            
            saveActionQuizSession()
            
            delegate?.featchRezultGame(session: actualSession!)
        
            let gameOverVC = GameOverViewController(model: ModelGameOver(
                settingSound: model.settingForGame.sounds,
                progressGame: actualSession!.progressForGame))
            
            self.navigationController?.pushViewController(gameOverVC, animated: true)
        }
    }
}


