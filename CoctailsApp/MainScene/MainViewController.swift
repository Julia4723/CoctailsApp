//
//  MainViewController.swift
//  CoctailsApp
//
//  Created by user on 03.07.2025.
//

import UIKit

protocol IMainViewController: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func showSuccess(_ message: String?)
    func configure(items: [MainCocktailModel])
}

final class MainViewController: UITableViewController {
    
    var presenter: IMainPresenter!
    
    private let cellIdentifier = "cell"
    private var allModels: [MainCocktailModel] = []
    
    override func viewDidLoad(){
        setupNavigationBar()
        setupTableView()
        presenter.render()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCoreData), name: .didAddNewCocktail, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.fetchFromStorage()
        self.presenter.fetchFromCore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Main"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Скрываем кнопку Back
        navigationItem.hidesBackButton = true
        let image = UIImage(systemName: "plus")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        
        
        let appearanceBig = UINavigationBarAppearance()
        appearanceBig.configureWithOpaqueBackground()
        appearanceBig.backgroundColor = .white
        
        appearanceBig.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        let appearanceSmall = UINavigationBarAppearance()
        appearanceSmall.configureWithOpaqueBackground()
        appearanceSmall.backgroundColor = .white
        
        appearanceSmall.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 20, weight: .medium)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearanceBig
        navigationController?.navigationBar.scrollEdgeAppearance = appearanceSmall
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(MainViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    @objc func addButtonTapped() {
        print("tapped")
        presenter.showNewCocktailVC()
    }
    
    @objc private func reloadCoreData() {
        presenter.fetchFromCore()
    }
}


extension MainViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainViewCell else {
            return UITableViewCell()
        }
        
        let item = allModels[indexPath.row]
        switch item {
        case .online(let cocktail):
            cell.configureCocktailModel(model: cocktail)
        case .save(let saved):
            cell.configureCoreModel(model: saved)
        }
        
        // Передаем FavoriteManager в ячейку
        if let presenter = presenter as? MainPresenter {
            cell.favoriteManager = presenter.favoriteManager
        }
        
        // Настраиваем обработчик нажатия на кнопку like
        cell.action = { [weak self] _ in
            print("🎯 MainViewController: Action triggered for index \(indexPath.row)")
            self?.presenter.toggleFavorite(at: indexPath.row)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.showScene(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = allModels[indexPath.row]
        guard editingStyle == .delete else { return }
        if case .save(_) = item {
            presenter.deleteCoreItem(at: IndexPath(row: indexPath.row, section: 0))
        }
    }
}


extension MainViewController: IMainViewController, UIStateManagerViewProtocol, UIStateManagerProtocol {
    
    var containerView: UIView {
        return view
    }
    
    func showLoading() {
        uiStateManager.showLoading()
    }
    
    func hideLoading() {
        uiStateManager.hideLoading()
    }
    
    func showError(_ message: String) {
        uiStateManager.showError(message)
    }
    
    func showSuccess(_ message: String?) {
        uiStateManager.showSuccess(message)
    }
    
    
    func configure(items: [MainCocktailModel]) {
        self.allModels = items
        tableView.reloadData()
    }
}
