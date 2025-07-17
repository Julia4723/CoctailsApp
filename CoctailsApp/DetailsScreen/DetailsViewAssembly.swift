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
    private let item: Cocktail
    
    init(navigationController: UINavigationController,  authService: AuthService, item: Cocktail) {
        self.navigationController = navigationController
        self.authService = authService
        self.item = item
    }
}


extension DetailsViewAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let detailsVC = viewController as? DetailsViewController else {return}
        
        let router = BaseRouter(navigationController: navigationController, authService: authService)
        let presenter = DetailsViewPresenter(view: detailsVC, authService: authService, router: router, model: item)
        detailsVC.presenter = presenter
        
    }
    
    
}
