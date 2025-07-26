//
//  SearchPresenter.swift
//  CoctailsApp
//
//  Created by user on 13.07.2025.
//

import UIKit

protocol ISearchPresenter {
    func search(for searchQuery: String)
    func filterContentForSearchText(_ searchText: String)
    var cocktails: [Cocktail] { get }
    var cocktailsCore: [CocktailItem] { get }
    func showScene(_ index: Int, _ section: Int)
    func render()
}

final class SearchPresenter {
    weak var view: ISearchViewController?
    private var filteredModel: [Cocktail] = []
    private var filteredModelCore: [CocktailItem] = []
    var cocktails: [Cocktail] = []
    var cocktailsCore: [CocktailItem] = []
    private let router: IBaseRouter
    private var networkManager = NetworkManager.shared
    private let authService: AuthService
    
    init(view: ISearchViewController, router: IBaseRouter, authService: AuthService) {
        self.view = view
        self.router = router
        self.authService = authService
    }
}


extension SearchPresenter: ISearchPresenter {
    func showScene(_ index: Int, _ section: Int) {
        if section == 0, index < filteredModel.count {
            let item = filteredModel[index]
            router.routeTo(target: BaseRouter.Target.detailsCocktailModelVC(item: item, itemCore: nil))
        } else if section == 1, index < filteredModelCore.count {
            let item = filteredModelCore[index]
            router.routeTo(target: BaseRouter.Target.detailsCocktailModelVC(item: nil, itemCore: item))
        }
    }
    
    
    func filterContentForSearchText(_ searchText: String) {
        filteredModel = cocktails.filter {
            ($0.strDrink?.lowercased().contains(searchText.lowercased()) ?? false)
        }
        filteredModelCore = cocktailsCore.filter { ($0.title?.lowercased().contains(searchText.lowercased()) ?? false)}
        view?.showSearchResult(filteredModel, filteredModelCore)
        print("🔍 Отфильтрованные элементы: \(filteredModel) \(filteredModelCore)")
    }
    
    
    
    func search(for searchQuery: String) {
        guard !searchQuery.isEmpty else {
            view?.showSearchResult(cocktails, cocktailsCore)
            return
        }
        networkManager.name = searchQuery
        networkManager.fetchSearch { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.filteredModel = success
                    self?.filteredModelCore = self?.cocktailsCore.filter{($0.title?.lowercased().contains(searchQuery.lowercased()) ?? false)} ?? []
                    self?.view?.showSearchResult(success, self?.filteredModelCore ?? [])
                    print("Найдено: \(success.count) элементов")
                case .failure(let failure):
                    self?.filteredModel = []
                    self?.filteredModelCore = []
                    print("❌ Ошибка поиска: \(failure.localizedDescription)")
                }
            }
        }
    }
    
    func render() {
        view?.configure(items: cocktails, itemsCore: cocktailsCore)
    }
    
    
    
}

