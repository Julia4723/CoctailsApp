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
    var cocktailsCore: [CocktailsCore] { get }
    func showScene(_ index: Int)
    func render()
}

final class SearchPresenter {
    weak var view: ISearchViewController?
    
    private var allFilteredModel: [MainCocktailModel] = []
    
    var cocktails: [Cocktail] = []
    var cocktailsCore: [CocktailsCore] = []
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
    func showScene(_ index: Int) {
        let item = allFilteredModel[index]
        router.routeTo(target: BaseRouter.Target.detailsCoreModelVC(item: item))
    }
    
    func filterContentForSearchText(_ searchText: String) {
        let filteredOnline = cocktails.filter {
            ($0.strDrink?.lowercased().contains(searchText.lowercased()) ?? false)
        }.map{ MainCocktailModel.online($0)}
        
        let filteredSave = cocktailsCore.filter { ($0.title?.lowercased().contains(searchText.lowercased()) ?? false)}.map{MainCocktailModel.save($0)}
        allFilteredModel = filteredOnline + filteredSave
        view?.showSearchResult(allFilteredModel)
    }
    
    
    
    func search(for searchQuery: String) {
        guard !searchQuery.isEmpty else {
            view?.showSearchResult(allFilteredModel)
            return
        }
        networkManager.name = searchQuery
        networkManager.fetchSearch { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    let filteredOnline = success.map { MainCocktailModel.online($0) }
                    let filteredSaved = self?.cocktailsCore.filter {
                        ($0.title?.lowercased().contains(searchQuery.lowercased()) ?? false)
                    }.map { MainCocktailModel.save($0) } ?? []
                    self?.allFilteredModel = filteredOnline + filteredSaved
                    self?.view?.showSearchResult(self?.allFilteredModel ?? [])
                    print("Найдено в поиске: \(success.count) элементов")
                case .failure(let failure):
                    self?.allFilteredModel = []
                    print("❌ Ошибка поиска: \(failure.localizedDescription)")
                }
            }
        }
    }
    
    func render() {
        view?.configure(items: allFilteredModel)
    }
}

