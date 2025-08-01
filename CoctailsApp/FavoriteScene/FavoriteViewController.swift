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
    var presener: IFavoritePresenter?
    
    private let cellIdentifier = "cell"
    private var items: [FavoriteViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
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


extension FavoriteViewController: IFavoriteViewController {
    func configure(items: [FavoriteViewModel]) {
        //
    }
    
    
}
