 //
//  SearchViewController.swift
//  CoctailsApp
//
//  Created by user on 03.07.2025.
//

import UIKit

protocol ISearchViewController: AnyObject {
    func showSearchResult(_ results: [MainCocktailModel])
    func configure(items:[MainCocktailModel])
}


final class SearchViewController: UITableViewController {
    
    var presenter: ISearchPresenter!
    private var networkManager = NetworkManager.shared
    
    private var filteredModel: [MainCocktailModel] = []
    
    private var allFilterModel: [MainCocktailModel] = []
    
    private let cellIdentifier = "cell"
    private let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.register(MainViewCell.self, forCellReuseIdentifier: cellIdentifier)
        setupSearchController()
        presenter.render()
    }
}

extension SearchViewController {
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredModel.count : allFilterModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainViewCell else {return UITableViewCell()}
        let model = isFiltering ? filteredModel[indexPath.row] : allFilterModel[indexPath.row]
        
        switch model {
        case .online(let cocktail):
            cell.configureCocktailModel(model: cocktail)
            
        case .save(let cocktailItem):
            cell.configureCoreModel(model: cocktailItem)
        }
        return cell
    }
}



extension SearchViewController: ISearchViewController, UISearchResultsUpdating {
    func showSearchResult(_ results: [MainCocktailModel]) {
        filteredModel = results
        tableView.reloadData()
    }
    
    func configure(items: [MainCocktailModel]) {
        allFilterModel = items
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter.search(for: searchController.searchBar.text ?? "")
    }
}
