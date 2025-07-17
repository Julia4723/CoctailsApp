//
//  BaseRouting.swift
//  CoctailsApp
//
//  Created by user on 30.06.2025.
//

import UIKit

protocol IBaseRouter: BaseRouting {}

final class BaseRouter {
    enum Target {
        case loginVC
        case main
        case popToRoot
        case signUpVC
        case detailsVC(item: Cocktail)
    }
    
    private let navigationController: UINavigationController
    private let authService: AuthService
   
    init(navigationController: UINavigationController, authService: AuthService) {
        self.navigationController = navigationController
        self.authService = authService
       
    }
}


extension BaseRouter: IBaseRouter {
    
    func routeTo(target: Any) {
        guard let target = target as? BaseRouter.Target else {return}
        
        switch target {
        case .loginVC:
            let loginVC = LoginViewController()
            
            let loginAssembly = LoginAssembly(navigationController: navigationController, authService: authService)
            loginAssembly.configure(viewController: loginVC)
            navigationController.setViewControllers([loginVC], animated: true)
            
        case .main:
            let tabBar = TabBarController()
            let tabBarAssembly = TabBarAssembly(navigationController: navigationController, authService: authService)
            tabBarAssembly.configure(viewController: tabBar)
            navigationController.setViewControllers([tabBar], animated: true)
            
        case .signUpVC:
            print("Router: routeTo signUpVC")
            let signUpVC = SignUpViewController()
            let signUpAssembly = SignUpAssembly(navigationController: navigationController, authService: authService)
            signUpAssembly.configure(viewController: signUpVC)
            navigationController.pushViewController(signUpVC, animated: true)
       
        case .popToRoot:
            navigationController.popToRootViewController(animated: true)
        case .detailsVC(item: let item):
            let detailVC = DetailsViewController()
            let detailAssembly = DetailsViewAssembly(navigationController: navigationController, authService: authService, item: item)
            detailAssembly.configure(viewController: detailVC)
            detailVC.modalPresentationStyle = .fullScreen
            navigationController.pushViewController(detailVC, animated: true)
        }
    }
}
