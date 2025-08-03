//
//  FavoriteAssembly.swift
//  CoctailsApp
//
//  Created by user on 28.07.2025.
//

import UIKit

final class FavoriteAssembly {
    private let navigationController: UINavigationController
    private let authService: AuthService
    private let favoriteManager: IFavoriteManager
    
    init(navigationController: UINavigationController, authService: AuthService, favoriteManager: IFavoriteManager) {
        self.navigationController = navigationController
        self.authService = authService
        self.favoriteManager = favoriteManager
    }
}


extension FavoriteAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let favoriteVC = viewController as? FavoriteViewController else {return}
        
        let router = BaseRouter(navigationController: navigationController, authService: authService)
        
        let presenter = FavoritePresenter(view: favoriteVC, router: router, favoriteManager: favoriteManager)
        favoriteVC.presenter = presenter
    }
}
