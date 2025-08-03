//
//  FavoritePresenter.swift
//  CoctailsApp
//
//  Created by user on 28.07.2025.
//

import UIKit

struct FavoriteViewModel {
    let description: String
    let image: String
    let title: String
    var isFavorite: Bool
}


protocol IFavoritePresenter {
    func showScene(_ index: Int)
    func render()
    func updateWithAllModels(_ models: [MainCocktailModel])
}


final class FavoritePresenter {
    private weak var view: IFavoriteViewController?
    private let router: IBaseRouter
    private let favoriteManager: IFavoriteManager
    private var allModels: [MainCocktailModel] = []
    
    init(view: IFavoriteViewController, router: IBaseRouter, favoriteManager: IFavoriteManager) {
        self.view = view
        self.router = router
        self.favoriteManager = favoriteManager
    }
    
    private func getFavoriteMusic() -> [FavoriteViewModel] {
        let favoriteModels = allModels.filter { favoriteManager.isFavorite($0) }
        return favoriteModels.map {
            FavoriteViewModel(
                description: $0.instructions,
                image: $0.imageURLString ?? "",
                title: $0.title,
                isFavorite: true
            )
        }
    }
}


extension FavoritePresenter: IFavoritePresenter {
    func showScene(_ index: Int) {
        let favoriteModels = allModels.filter { favoriteManager.isFavorite($0) }
        guard index < favoriteModels.count else { return }
        router.routeTo(target: BaseRouter.Target.detailsCoreModelVC(item: favoriteModels[index]))
    }
    
    func render() {
        view?.configure(items: getFavoriteMusic())
    }
    
    func updateWithAllModels(_ models: [MainCocktailModel]) {
        allModels = models
        favoriteManager.updateAllModels(models)
        render()
    }
}
