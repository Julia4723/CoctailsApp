//
//  FavoriteViewController.swift
//  CoctailsApp
//
//  Created by user on 28.07.2025.
//

import UIKit

protocol IFavoriteViewController: AnyObject {
    func configure(items: [FavoriteViewModel])
}


final class FavoriteViewController: UITableViewController {
    var presenter: IFavoritePresenter?
    
    private let cellIdentifier = "cell"
    private var items: [FavoriteViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        
        // Слушаем уведомления об обновлении данных
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateFavoriteModels),
            name: NSNotification.Name("UpdateFavoriteModels"),
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
        // Запрашиваем обновление данных при появлении экрана
        NotificationCenter.default.post(
            name: NSNotification.Name("RequestFavoriteModels"),
            object: nil
        )
    }
    
    @objc private func updateFavoriteModels(_ notification: Notification) {
        if let models = notification.object as? [MainCocktailModel] {
            presenter?.updateWithAllModels(models)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Favorite"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Скрываем кнопку Back
        navigationItem.hidesBackButton = true
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
    }
}

extension FavoriteViewController {
    private func setupTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(MainViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}


extension FavoriteViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainViewCell else {return UITableViewCell()}
        let item = items[indexPath.row]
        cell.configureFavoriteModel(model: item)
        return cell
    }
}

extension FavoriteViewController: IFavoriteViewController {
    func configure(items: [FavoriteViewModel]) {
        self.items = items
        tableView.reloadData()
    }
}
