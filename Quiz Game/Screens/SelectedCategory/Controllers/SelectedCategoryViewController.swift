//
//  SelectedCategoryViewController.swift
//  Quiz Game
//
//  Created by APPLE on 10.07.2022.
//

import UIKit

final class SelectedCategoryViewController: UIViewController {
    
    //MARK: Properties
    fileprivate var selectView: SelectedCategoryView {
        guard let view = self.view as? SelectedCategoryView else {return SelectedCategoryView()}
        return view
    }
    
    private let header = "Category"
        
    private var dataSource: SelectedCategoryDataSource
    
    public var delegate: SelectViewControllerDataSourse?
    
    //MARK: Init
    init(model: ModelSelectedCategory) {
        self.dataSource = SelectedCategoryDataSource(model: model)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = SelectedCategoryView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = header
        setupNavigationBar()
        setupTableView()
        dataSource.output = self
   
        selectView.configure(with: ModelSelectedCategoryView(
            onBackButton: {
                
            }))
    }
    
    private func setupTableView() {
        selectView.tableView.delegate = dataSource
        selectView.tableView.dataSource = dataSource
        selectView.tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifire)
        
        selectView.tableView.tableFooterView = UIView()
        selectView.tableView.separatorStyle = .none
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.hidesBackButton = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Colors.mainBackgroundColor
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.compactAppearance = appearance
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        SoundPlayer.shared.setButtonTapSound(sound: SoundPlayer.shared.tapButtonSound, setting: dataSource.model.settingSound)
    }
}
extension SelectedCategoryViewController: SelectedCategoryDataSourceOutput {
    
    func updateCategory(category: CategoryType) {
        delegate?.updateCurrentCategory(category: category)
    }
}
