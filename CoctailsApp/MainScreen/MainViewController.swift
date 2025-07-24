//
//  MainViewController.swift
//  CoctailsApp
//
//  Created by user on 03.07.2025.
//

import UIKit

protocol IMainViewController: AnyObject {
    func updateView()
    func showError(error: Error)
    func configureCoctailModel(items: [Cocktail])
    func configureCoreModel(items: [CocktailItem])
}

final class MainViewController: UITableViewController {
    
    var presenter: IMainPresenter!
    
    private let cellIdentifier = "cell"
    private var items: [Cocktail] = []
    private var coreItems: [CocktailItem] = []
    
    override func viewDidLoad(){
        setupView()
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
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .systemBackground
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
    
    private var allModels: [Any] {
        return coreItems + items
    }
}

private extension MainViewController {
    func setupView() {
        view.backgroundColor = .red
    }
}

extension MainViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return items.count
        case 1:
            return coreItems.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Онлайн коктейли"
        case 1:
            return "Сохранённые коктейли"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainViewCell else {return UITableViewCell()}
        
        if indexPath.section == 0 {
            let item = items[indexPath.row]
            cell.configureCocktailModel(model: item)
        } else {
            let item = coreItems[indexPath.row]
            cell.configureCoreModel(model: item)
            
        }
        
//        let item = items[indexPath.row]
//        cell.configureCocktailModel(model: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.showScene(indexPath.row)
    }
}


extension MainViewController: IMainViewController {
    func configureCoreModel(items: [CocktailItem]) {
        self.coreItems = items
        tableView.reloadData()
    }
    
    func configureCoctailModel(items: [Cocktail]) {
        self.items = items
        tableView.reloadData()
    }
    
    func showError(error: any Error) {
        print(error)
    }
    
    func updateView() {
        tableView.reloadData()
    }
}
