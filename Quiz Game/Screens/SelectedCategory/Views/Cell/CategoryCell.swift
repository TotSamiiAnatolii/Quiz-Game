//
//  CategoryCell.swift
//  Quiz Game
//
//  Created by APPLE on 14.07.2022.
//

import UIKit

final class CategoryCell: UITableViewCell {
    
    //MARK: Properties
    static let identifire = "CatygoryCell"
    
    private let topSeparator = UIView(frame: .zero)
    
    private let bottomSeparator = UIView(frame: .zero)
    
    private var shapeLayer = CAShapeLayer()
    
    private var shapeLayerBackground = CAShapeLayer()
    
    private var hidesTopSeparator = false
    
    private var hidesBottomSeparator = false
    
    private let indent: CGFloat = 15
    
    override var isSelected: Bool  {
        didSet {
            if isSelected {
                
                imageChekMark.isHidden = false
            } else {
                
                imageChekMark.isHidden = true
            }
        }
    }
    
    private let imageChekMark = UIImageView()
        .setMyStyle()
        .setImage(image: Image.checkMark)

    private let viewContainer = UIView()
        .setStyle()
    
    private let stateLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: UIFont.preferredFont(forTextStyle: .title3).withSize(16))
    
    private let nameTypeLable = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .body).withSize(17))
        .setLineBreakMode(lineBreak: .byTruncatingHead)
    
    private let questionCountLable = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: UIFont.preferredFont(forTextStyle: .body).withSize(14))
        .setTextColor(color: .gray)
    
    private let containerStackView = UIStackView()
        .myStyleStack(
            spacing: 4,
            alignment: .leading,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: false)
        .setLayoutMargins(top: 0, left: 15, bottom: 0, right: 0)
    
    private func trajectoryShape() {
        let centr = CGPoint(x: viewContainer.frame.width / 2, y: viewContainer.frame.height / 2)
        
        let circularPath = UIBezierPath(arcCenter: centr, radius: 30, startAngle: -( (CGFloat.pi) / 2 ), endAngle: (3 * CGFloat.pi) / 2  , clockwise: true)
        
        shapeLayerBackground.path = circularPath.cgPath
        shapeLayerBackground.lineWidth = 5
        shapeLayerBackground.fillColor = UIColor.clear.cgColor
        shapeLayerBackground.strokeEnd = 1
        shapeLayerBackground.strokeColor = Colors.circularProgress
        shapeLayerBackground.lineCap = .round
        viewContainer.layer.addSublayer(shapeLayerBackground)
        layoutIfNeeded()
    }
    
    private func progressBar() {
        let centr = CGPoint(x: viewContainer.frame.width / 2, y: viewContainer.frame.height / 2)
        
        let circularPath = UIBezierPath(arcCenter: centr, radius: 30, startAngle: 0 - ( (CGFloat.pi) / 2 ), endAngle: (3 * CGFloat.pi) / 2  , clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.lineCap = .round
        viewContainer.layer.addSublayer(shapeLayer)
    }
    
    private func addDropShadow(color: UIColor, offset: CGSize, btnLayer: CALayer) {
        btnLayer.masksToBounds = false
        btnLayer.shadowColor = color.cgColor
        btnLayer.shadowOpacity = 5
        btnLayer.shadowOffset = offset
        btnLayer.shadowRadius = 2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        trajectoryShape()
        progressBar()
    }
    
    //MARK: Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
        self.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: .zero)
        topSeparator.isHidden = true
        bottomSeparator.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        viewContainer.layer.cornerRadius =  viewContainer.frame.height / 2
        addDropShadow(color: #colorLiteral(red: 0.9287541278, green: 0.9287541278, blue: 0.9287541278, alpha: 1), offset: CGSize(width: 1, height: 1), btnLayer: shapeLayerBackground)
    }
    
    private func recognizer (value: Float) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = value / 100
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urS")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setViewHierarhies()
        setConstraint()
        setupSeparators()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(viewContainer)
        contentView.addSubview(containerStackView)
        contentView.addSubview(imageChekMark)
        containerStackView.addArrangedSubview(nameTypeLable)
        containerStackView.addArrangedSubview(questionCountLable)
        viewContainer.addSubview(stateLabel)
        contentView.addSubview(topSeparator)
        contentView.addSubview(bottomSeparator)
    }

    private func setConstraint() {
        NSLayoutConstraint.activate([
            viewContainer.widthAnchor.constraint(equalToConstant: 60),
            viewContainer.heightAnchor.constraint(equalToConstant: 60),
            viewContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent)
        ])
        
        NSLayoutConstraint.activate([
            stateLabel.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            stateLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageChekMark.widthAnchor.constraint(equalToConstant: 22),
            imageChekMark.heightAnchor.constraint(equalToConstant: 22),
            imageChekMark.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageChekMark.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -indent)
        ])
        
        NSLayoutConstraint.activate([
            containerStackView.leftAnchor.constraint(equalTo: viewContainer.rightAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor)
        ])
    }
    
    private func setupSeparators() {
        
        topSeparator.backgroundColor = Colors.separatorColor
        bottomSeparator.backgroundColor = Colors.separatorColor
        
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: nameTypeLable.leadingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 0.3),
            
            bottomSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: topSeparator.trailingAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: topSeparator.leadingAnchor),
            bottomSeparator.heightAnchor.constraint(equalTo: topSeparator.heightAnchor)
        ])
    }

    public func setSeparator(indexPath: IndexPath, count: Int) {

        let lastCell = count - 1
        
        switch indexPath.row {
        case 0 :
            topSeparator.isHidden = true
        case lastCell:
            bottomSeparator.isHidden = true
        default:
            topSeparator.isHidden = false
            bottomSeparator.isHidden = false
        }
    }
    
    public func setCornerRadius(indexPath: IndexPath, count: Int) {
        
        let lastCell = count - 1
        
        switch indexPath.row {
        case 0 :
            self.roundCorners([.topLeft, .topRight],
                              radius: AppDesign.mainCornerRadius)
            if indexPath.row == lastCell {
                self.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: AppDesign.mainCornerRadius)
                
            }
        case lastCell:
            self.roundCorners([.bottomLeft, .bottomRight],
                              radius: AppDesign.mainCornerRadius)
        default:
            break
        }
        
    }
}

//MARK: Extension
extension CategoryCell: ConfigurableView {

    typealias Model = ModelSelectedCategoryCell
    
    func configure(with model: Model) {
        self.stateLabel.text = "\(String(format: "%.0f", model.state))%"
        self.recognizer(value: model.state)
        self.nameTypeLable.text = model.nameType
        self.questionCountLable.text = "Question count: \(model.countQuestion)"
    }
}

