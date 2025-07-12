//
//  TabBarController.swift
//  CoctailsApp
//
//  Created by user on 28.06.2025.
//

import UIKit

//посмотртеть реализацию в приложении BookStoreApp или общем проекте с музыкой

enum TabsAssembly {
    case mainVC
    case searchVC
    case profileVC
    
    static let allTabs = [mainVC, searchVC, profileVC]
}

protocol ITabBarViewController: AnyObject {
    func setTabBarItems(_ items: [TabBarItemInfo], appearance: UITabBarAppearance)
    func initializeTabBar()
}


final class TabBarController: UITabBarController {
    var presenter: ITabBarViewPresenter!
    private let allTabsItem = TabsAssembly.allTabs
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TabBarController: ITabBarViewController {
  
    
    func setTabBarItems(_ items: [TabBarItemInfo], appearance: UITabBarAppearance) {
        
        // Создаем контроллеры и сразу устанавливаем их tabBarItem
        let controllers = items.map { item -> UIViewController in
            let controller = item.viewController
            controller.tabBarItem.title = item.title
            controller.tabBarItem.image = item.icon
            return controller
        }
        
        // Устанавливаем контроллеры
        self.viewControllers = controllers
        
        // Настраиваем appearance
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    func initializeTabBar() {
        presenter.getTabBarItems()
    }
}
