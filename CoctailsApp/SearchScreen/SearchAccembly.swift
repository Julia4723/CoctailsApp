//
//  SearchAccembly.swift
//  CoctailsApp
//
//  Created by user on 13.07.2025.
//

import UIKit

 

final class SearchAccembly {
    let navigationController: UINavigationController
    let authService: AuthService
    
    init(navigationController: UINavigationController, authService: AuthService, network: INetworkManager) {
        self.navigationController = navigationController
        self.authService = authService
    }
}


extension SearchAccembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let searchVC = viewController as? SearchViewController else {return}
        
        let router = BaseRouter(navigationController: navigationController, authService: authService)
        let presenter = SearchPresenter(view: searchVC, router: router, authService: authService)
        searchVC.presenter = presenter
    }
}
