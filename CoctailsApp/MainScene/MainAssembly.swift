//
//  MainAssembly.swift
//  CoctailsApp
//
//  Created by user on 03.07.2025.
//

import UIKit


final class MainAssembly {
    
    private let navigationController: UINavigationController
    private let authService: AuthService
    private let network: INetworkManager
    private let favoriteManager: IFavoriteManager
    
    init(navigationController: UINavigationController, authService: AuthService, network: INetworkManager, favoriteManager: IFavoriteManager) {
        self.navigationController = navigationController
        self.authService = authService
        self.network = network
        self.favoriteManager = favoriteManager
    }
    
}


extension MainAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let mainVC = viewController as? MainViewController else {return}
        
        let router = BaseRouter(navigationController: navigationController, authService: authService)
        let presenter = MainPresenter(view: mainVC, router: router, network: network, favoriteManager: favoriteManager)
        mainVC.presenter = presenter
    }
}
