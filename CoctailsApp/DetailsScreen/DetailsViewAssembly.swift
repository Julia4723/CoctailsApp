//
//  DetailsViewAssembly.swift
//  CoctailsApp
//
//  Created by user on 16.07.2025.
//

import UIKit


final class DetailsViewAssembly {
    private let navigationController: UINavigationController
    private let authService: AuthService
    private let item: Cocktail?
    private let itemCore: CocktailItem?
    
    init(navigationController: UINavigationController,  authService: AuthService, item: Cocktail?, itemCore: CocktailItem?) {
        self.navigationController = navigationController
        self.authService = authService
        self.item = item
        self.itemCore = itemCore
    }
}


extension DetailsViewAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let detailsVC = viewController as? DetailsViewController else {return}
        
        let router = BaseRouter(navigationController: navigationController, authService: authService)
        let presenter = DetailsViewPresenter(view: detailsVC, authService: authService, router: router, model: item, modelCore: itemCore)
        detailsVC.presenter = presenter
        
    }
    
    
}
