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
    func showScene(_ index: Int)
    func render()
}

final class SearchPresenter {
    weak var view: ISearchViewController?
    private var filteredModel: [Cocktail] = []
    var cocktails: [Cocktail] = []
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
    func filterContentForSearchText(_ searchText: String) {
        filteredModel = cocktails.filter {
            ($0.strDrink?.lowercased().contains(searchText.lowercased()) ?? false)
        }
        view?.showSearchResult(filteredModel)
        print("🔍 Отфильтрованные элементы: \(filteredModel)")
    }
    
    
    
    func search(for searchQuery: String) {
        guard !searchQuery.isEmpty else {
            view?.showSearchResult(cocktails)
            return
        }
        networkManager.name = searchQuery
        networkManager.fetchSearch { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.filteredModel = success
                    self?.view?.showSearchResult(success)
                    print("Найдено: \(success.count) элементов")
                case .failure(let failure):
                    self?.filteredModel = []
                    print("❌ Ошибка поиска: \(failure.localizedDescription)")
                }
            }
        }
    }
    
    func render() {
        view?.configure(items: cocktails)
    }
    
    func showScene(_ index: Int) {
        router.routeTo(target: BaseRouter.Target.detailsVC(item: filteredModel[index]))
    }
    
}

