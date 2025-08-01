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
    private let item: MainCocktailModel
    
    init(navigationController: UINavigationController,  authService: AuthService, item: MainCocktailModel) {
        self.navigationController = navigationController
        self.authService = authService
        self.item = item
    }
}


extension DetailsViewAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let detailsVC = viewController as? DetailsViewController else {return}
        
        let router = BaseRouter(navigationController: navigationController, authService: authService)
        let presenter = DetailsViewPresenter(view: detailsVC, authService: authService, router: router, allModels: item)
        detailsVC.presenter = presenter
        
    }
}
