//
//  NewCocktailAssembly.swift
//  CoctailsApp
//
//  Created by user on 19.07.2025.
//

import UIKit

final class NewCocktailAssembly {
    private let navigationController: UINavigationController
    private let authService: AuthService
 
    init(navigationController: UINavigationController, authService: AuthService) {
        self.navigationController = navigationController
        self.authService = authService
    }
}


extension NewCocktailAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let newCocktailVC = viewController as? NewCocktailViewController else {return}
        
        let router = BaseRouter(navigationController: navigationController, authService: authService)
        let model = NewCocktailModel()
        let presenter = NewCocktailPresenter(view: newCocktailVC, model: model, authService: authService, router: router)
        newCocktailVC.presenter = presenter
    }
}
