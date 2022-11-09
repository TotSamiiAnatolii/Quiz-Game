//
//  GameOverView.swift
//  Quiz Game
//
//  Created by APPLE on 08.07.2022.
//

import UIKit

final class GameOverView: UIView {
    
    //MARK: Properties
    private var onAction: ((ButtonType)->())?
    
    private var shapeLayer = CAShapeLayer()
    
    private let shapeLayerBackground = CAShapeLayer()
    
    private lazy var radius = self.frame.width * 0.3
    
    private lazy var indent = self.radius + 40
    
    private let percentCorrectAnswer = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: UIFont.preferredFont(forTextStyle: .largeTitle).withSize(50))
    
    private let rezultLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .largeTitle).withSize(20))
    
    private let gameOverLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: AppDesign.fontMainHeader)
    
    lazy var buttonGameOver = MyButton()
        .setMyStyle(backgroundColor: .white)
        .setShadow()
        .setStyleTitle(color: .black, font: AppDesign.fontForButton)
        .setTarget(method:  #selector(buttonAction),
                   target: self,
                   event: .touchUpInside)
    
    lazy var buttonRepeat = MyButton()
        .setMyStyle(backgroundColor: .white)
        .setShadow()
        .setStyleTitle(color: .black, font: AppDesign.fontForButton)
        .setTarget(method:  #selector(buttonAction),
                   target: self,
                   event: .touchUpInside)
    
    private let containerForRezultGame = UIStackView()
        .myStyleStack(
            spacing: 5,
            alignment: .center,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: true)
    
    private let containerForButton = UIStackView()
        .myStyleStack(
            spacing: 20,
            alignment: .center,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: true)
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackgroundColor
        setViewHierarhies()
        setConstraint()
        trajectoryShape()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(gameOverLabel)
        containerForRezultGame.addArrangedSubview(percentCorrectAnswer)
        containerForRezultGame.addArrangedSubview(rezultLabel)
        self.addSubview(containerForRezultGame)
        containerForButton.addArrangedSubview(buttonRepeat)
        containerForButton.addArrangedSubview(buttonGameOver)
        self.addSubview(containerForButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addDropShadow(color: #colorLiteral(red: 0.8255505231, green: 0.8096129452, blue: 0.8533376433, alpha: 1), offset: CGSize(width: 1, height: 1), btnLayer: shapeLayerBackground)
    }
    
    private func setConstraint() {
        
        NSLayoutConstraint.activate([
            gameOverLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            gameOverLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -indent)
        ])
        
        NSLayoutConstraint.activate([
            buttonRepeat.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.56),
            buttonRepeat.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        NSLayoutConstraint.activate([
            buttonGameOver.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.56),
            buttonGameOver.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        NSLayoutConstraint.activate([
            containerForButton.topAnchor.constraint(equalTo: self.centerYAnchor, constant: indent),
            containerForButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerForRezultGame.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerForRezultGame.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func addDropShadow(color: UIColor, offset: CGSize, btnLayer: CALayer) {
        btnLayer.masksToBounds = false
        btnLayer.shadowColor = color.cgColor
        btnLayer.shadowOpacity = 4
        btnLayer.shadowOffset = offset
        btnLayer.shadowRadius = 5
    }
    
    private func recognizer(toValue: Float) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = toValue
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "progress")
    }
    
    private func trajectoryShape() {
        let centr = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        
        let circularPath = UIBezierPath(arcCenter: centr, radius: radius, startAngle:  -( (CGFloat.pi) / 2 ), endAngle: (3 * CGFloat.pi) / 2  , clockwise: true)
        
        shapeLayerBackground.path = circularPath.cgPath
        shapeLayerBackground.lineWidth = 12
        shapeLayerBackground.fillColor = UIColor.clear.cgColor
        shapeLayerBackground.strokeEnd = 1
        shapeLayerBackground.strokeColor = #colorLiteral(red: 0.9923724112, green: 0.9923724112, blue: 0.9923724112, alpha: 1)
        shapeLayerBackground.lineCap = .round
        self.layer.addSublayer(shapeLayerBackground)
    }
    
    public func progressBar(toValue: Float) {
        let centr = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        
        let circularPath = UIBezierPath(arcCenter: centr, radius: radius, startAngle: 0 - ( (CGFloat.pi) / 2 ), endAngle: (3 * CGFloat.pi) / 2  , clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 12
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.lineCap = .round
        self.layer.addSublayer(shapeLayer)
        recognizer(toValue: toValue)
    }
    
    @objc func buttonAction(sender: UIButton) {
        
        switch sender {
        case buttonGameOver:
            onAction?(.finish)
        case buttonRepeat:
            onAction?(.repeatGame)
        default:
            break
        }
    }
    
    //MARK: Public methods
    public func configureRezulLabel(rezult: String) {
        rezultLabel.text = rezult
        rezultLabel.isHidden = false
    }
    
    public func configureGameOverView(correct percent: Float) {
        percentCorrectAnswer.text = "\(String(format: "%.0f", percent))%"
    }
}
//MARK: Extension
extension GameOverView: ConfigurableView {
    
    typealias Model = ModelGameOverView
    
    func configure(with model: ModelGameOverView) {
        self.onAction = model.onAction
        self.gameOverLabel.text = model.header
        
        self.buttonGameOver.configure(with: ModelButton(
            title: model.finishLabel,
            image: nil))
        self.buttonRepeat.configure(with: ModelButton(
            title: model.repeatLabel,
            image: nil))
    }
}
