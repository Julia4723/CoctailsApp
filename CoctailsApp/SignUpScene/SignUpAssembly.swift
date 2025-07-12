//
//  FirstAssembly.swift
//  CoctailsApp
//
//  Created by user on 27.06.2025.
//

import UIKit

final class SignUpAssembly {
    private let navigationController: UINavigationController
    private let authService: AuthService
    
    init(navigationController: UINavigationController, authService: AuthService) {
        self.navigationController = navigationController
        self.authService = authService
    }
}

extension SignUpAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let signUpVC = viewController as? SignUpViewController else {return}
        
        let router = BaseRouter(navigationController: navigationController, authService: authService)
        
        let presenter = SignUpViewPresenter(router: router, view: signUpVC, authService: authService)
        
        signUpVC.presenter = presenter
    }
}
