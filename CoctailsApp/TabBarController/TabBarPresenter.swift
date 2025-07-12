//
//  TabBarPresenter.swift
//  CoctailsApp
//
//  Created by user on 04.07.2025.
//

import UIKit

struct TabBarItemInfo {
    let viewController: UIViewController
    let title: String
    let icon: UIImage?
}




protocol ITabBarViewPresenter {
    func getTabBarItems()
}

final class TabBarPresenter {
    private weak var view: ITabBarViewController?
    private let router: IBaseRouter
    private let navigationController: UINavigationController
    private let authService: AuthService
    private let network: INetworkManager

    init(view: ITabBarViewController, router: IBaseRouter, navigationController: UINavigationController, authService: AuthService, network: INetworkManager) {
        self.view = view
        self.router = router
        self.navigationController = navigationController
        self.authService = authService
        self.network = network
    }
}


extension TabBarPresenter: ITabBarViewPresenter {
    
    
    func getTabBarItems() {
        // Сборка Main
        let mainVC = MainViewController()
        let mainAssembly = MainAssembly(navigationController: navigationController, authService: authService, network: network)
        mainAssembly.configure(viewController: mainVC)
        let mainNav = UINavigationController(rootViewController: mainVC)

        // Сборка Search (если появится Assembly, заменить)
        let searchVC = SearchViewController()
        let searchNav = UINavigationController(rootViewController: searchVC)

        // Сборка Profile
        let profileVC = ProfileViewController()
        let profileAssembly = ProfileAssembly(navigationController: navigationController, authService: authService)
        profileAssembly.configure(viewController: profileVC)
        let profileNav = UINavigationController(rootViewController: profileVC)

        let items: [TabBarItemInfo] = [
            TabBarItemInfo(
                viewController: mainNav,
                title: "Main",
                icon: UIImage(systemName: "house.fill")
            ),
            TabBarItemInfo(
                viewController: searchNav,
                title: "Search",
                icon: UIImage(systemName: "magnifyingglass")
            ),
            TabBarItemInfo(
                viewController: profileNav,
                title: "Profile",
                icon: UIImage(systemName: "person.fill")
            )
        ]
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.iconColor = .blue
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.blue]
        
        appearance.stackedLayoutAppearance.selected.badgeBackgroundColor = .systemGray5
       
        
       view?.setTabBarItems(items, appearance: appearance)
    }
    
    
}
