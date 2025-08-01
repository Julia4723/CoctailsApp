//
//  ProfileAssembly.swift
//  CoctailsApp
//
//  Created by user on 07.07.2025.
//

import UIKit

final class ProfileAssembly {
    private let navigationController: UINavigationController
    let authService: AuthService
    
    init(navigationController: UINavigationController, authService: AuthService) {
        self.navigationController = navigationController
        self.authService = authService
    }
}


extension ProfileAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let profileVC = viewController as? ProfileViewController else
        {return}
        
        let router = BaseRouter(navigationController: navigationController, authService: authService)
        let presenter = ProfileViewPresenter(view: profileVC, router: router, authService: authService)
        profileVC.presenter = presenter
    }
}
