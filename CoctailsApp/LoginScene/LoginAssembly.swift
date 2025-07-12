//
//  LoginAccembly.swift
//  CoctailsApp
//
//  Created by user on 28.06.2025.
//

import UIKit

final class LoginAssembly {
    private let navigationController: UINavigationController
    let authService: AuthService
    
    init(navigationController: UINavigationController,  authService: AuthService) {
        self.navigationController = navigationController
        self.authService = authService
    }
}


extension LoginAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
       
        guard let loginVC = viewController as? LoginViewController else {return}
        
        let router = BaseRouter(navigationController: navigationController, authService: authService)
        let presenter = LoginPresenter(view: loginVC, authService: authService, router: router)
        loginVC.presenter = presenter

    }
}
