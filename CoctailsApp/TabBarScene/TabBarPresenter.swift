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
    private let favoriteManager: IFavoriteManager

    init(view: ITabBarViewController, router: IBaseRouter, navigationController: UINavigationController, authService: AuthService, network: INetworkManager, favoriteManager: IFavoriteManager) {
        self.view = view
        self.router = router
        self.navigationController = navigationController
        self.authService = authService
        self.network = network
        self.favoriteManager = favoriteManager
    }
}


extension TabBarPresenter: ITabBarViewPresenter {
    
    
    func getTabBarItems() {
        // Сборка Main
        let mainVC = MainViewController()
        let mainAssembly = MainAssembly(navigationController: navigationController, authService: authService, network: network, favoriteManager: favoriteManager)
        mainAssembly.configure(viewController: mainVC)
        let mainNav = UINavigationController(rootViewController: mainVC)

        
        // Сборка Search
        let searchVC = SearchViewController()
        let searchAssembly = SearchAccembly(navigationController: navigationController, authService: authService, network: network)
        searchAssembly.configure(viewController: searchVC)
        let searchNav = UINavigationController(rootViewController: searchVC)

        
        // Сборка Profile
        let profileVC = ProfileViewController()
        let profileAssembly = ProfileAssembly(navigationController: navigationController, authService: authService)
        profileAssembly.configure(viewController: profileVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        let favoriteVC = FavoriteViewController()
        let favoriteAssembly = FavoriteAssembly(navigationController: navigationController, authService: authService, favoriteManager: favoriteManager)
        favoriteAssembly.configure(viewController: favoriteVC)
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)

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
            ),
            TabBarItemInfo(
                viewController: favoriteNav,
                title: "Favorite",
                icon: UIImage(systemName: "heart.fill")
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
