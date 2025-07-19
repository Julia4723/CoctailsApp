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
    func configure(items: [Cocktail])
}

final class MainViewController: UITableViewController {
    
    var presenter: IMainPresenter!
    
    private let cellIdentifier = "cell"
    private var items: [Cocktail] = []
    
    override func viewDidLoad(){
        setupView()
        setupNavigationBar()
        setupTableView()
        presenter.render()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.fetchFromStorage()
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
}

private extension MainViewController {
    func setupView() {
        view.backgroundColor = .red
    }
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainViewCell else {return UITableViewCell()}
        //let item = self.presenter.cocktails[indexPath.row]
        let item = items[indexPath.row]
        cell.configure(model: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.showScene(indexPath.row)
    }
}


extension MainViewController: IMainViewController {
    func configure(items: [Cocktail]) {
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
