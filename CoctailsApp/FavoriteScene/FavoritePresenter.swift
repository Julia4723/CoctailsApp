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
}


protocol IFavoritePresenter {
    
}


final class FavoritePresenter {
    private weak var view: IFavoriteViewController?
    private let router: IBaseRouter
    private var items: [Cocktail] = []
    private var coreItems: [CocktailsCore] = []
    
    init(view: IFavoriteViewController, router: IBaseRouter) {
        self.view = view
        self.router = router
    }
}


extension FavoritePresenter: IFavoritePresenter {
    
}
