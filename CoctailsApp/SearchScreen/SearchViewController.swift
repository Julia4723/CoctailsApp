//
//  SearchViewController.swift
//  CoctailsApp
//
//  Created by user on 03.07.2025.
//

import UIKit

protocol ISearchViewController: AnyObject {
    func showSearchResult(_ results: [Cocktail], _ resultsCore: [CocktailItem])
    func configure(items:[Cocktail], itemsCore: [CocktailItem])
}


final class SearchViewController: UITableViewController {
  
    var presenter: ISearchPresenter!
    private var networkManager = NetworkManager.shared
    private var filteredModel: [Cocktail] = []
    private var filteredModelCore: [CocktailItem] = []
    private var items: [Cocktail] = []
    private var itemsCore: [CocktailItem] = []
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Онлайн коктейли"
        case 1: return "Сохранённые коктейли"
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return section == 0 ? filteredModel.count : filteredModelCore.count
        } else {
            return section == 1 ? presenter.cocktails.count : presenter.cocktailsCore.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainViewCell else {return UITableViewCell()}
        
        if isFiltering {
            if indexPath.section == 0 {
                let item = filteredModel[indexPath.row]
                cell.configureCocktailModel(model: item)
            } else {
                let item = filteredModelCore[indexPath.row]
                cell.configureCoreModel(model: item)
            }
        } else {
            if indexPath.section == 1 {
                let item = presenter.cocktails[indexPath.row]
                cell.configureCocktailModel(model: item)
            } else {
                let item = presenter.cocktailsCore[indexPath.row]
                cell.configureCoreModel(model: item)
            }
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.showScene(indexPath.row)
    }
}


extension SearchViewController: ISearchViewController, UISearchResultsUpdating {
    func showSearchResult(_ results: [Cocktail], _ resultsCore: [CocktailItem]) {
        filteredModel = results
        filteredModelCore = resultsCore
        tableView.reloadData()
    }
    
    func configure(items: [Cocktail], itemsCore: [CocktailItem]) {
        filteredModel = items
        filteredModelCore = itemsCore
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter.search(for: searchController.searchBar.text ?? "")
    }
}
