//
//  SearchViewController.swift
//  CoctailsApp
//
//  Created by user on 03.07.2025.
//

import UIKit

protocol ISearchViewController: AnyObject {
    func showSearchResult(_ results: [Cocktail])
    func configure(items:[Cocktail])
}


final class SearchViewController: UITableViewController {
  
    var presenter: ISearchPresenter!
    private var networkManager = NetworkManager.shared
    private var filteredModel: [Cocktail] = []
    private var items: [Cocktail] = []
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
        return isFiltering ? filteredModel.count : presenter.cocktails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainViewCell else {return UITableViewCell()}
        
        if let item = isFiltering ? filteredModel[indexPath.row] : presenter?.cocktails[indexPath.row] {
            cell.configureCocktailModel(model: item)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.showScene(indexPath.row)
    }
}


extension SearchViewController: ISearchViewController, UISearchResultsUpdating {
    func configure(items: [Cocktail]) {
        filteredModel = items
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter.search(for: searchController.searchBar.text ?? "")
    }
    func showSearchResult(_ results: [Cocktail]) {
        self.filteredModel = results
        tableView.reloadData()
    }
}
