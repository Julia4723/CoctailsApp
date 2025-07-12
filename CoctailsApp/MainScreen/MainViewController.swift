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
}

final class MainViewController: UITableViewController {
    
    var presenter: IMainPresenter!
    
    private let cellIdentifier = "cell"
    private var items: [Cocktail] = []
    
    override func viewDidLoad(){
        self.presenter.view = self
        setupView()
        setupNavigationBar()
        setupTableView()
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
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.register(MainViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

private extension MainViewController {
    func setupView() {
        view.backgroundColor = .red
    }
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.cocktails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainViewCell else {return UITableViewCell()}
        let item = self.presenter.cocktails[indexPath.row]
        cell.configure(model: item)
        return cell
    }
}


extension MainViewController: IMainViewController {
    func showError(error: any Error) {
        print(error)
    }
    
    func updateView() {
        tableView.reloadData()
    }
}
