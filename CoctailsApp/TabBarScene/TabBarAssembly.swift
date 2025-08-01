//
//  TabBarAssembly.swift
//  CoctailsApp
//
//  Created by user on 04.07.2025.
//
import UIKit

final class TabBarAssembly {
    private let navigationController: UINavigationController
    private let authService: AuthService
   
    init(navigationController: UINavigationController, authService: AuthService) {
        self.navigationController = navigationController
        self.authService = authService
        
    }
}


extension TabBarAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let tabBarVC = viewController as? TabBarController else {
            return
        }

        let router = BaseRouter(navigationController: navigationController, authService: authService)
        let network = NetworkManager.shared
        let presenter = TabBarPresenter(view: tabBarVC, router: router, navigationController: navigationController, authService: authService, network: network)
        
        tabBarVC.presenter = presenter

        // Инициализируем TabBar после настройки presenter
        tabBarVC.initializeTabBar()
    }
}
