//
//  ProfileViewPresenter.swift
//  CoctailsApp
//
//  Created by user on 07.07.2025.
//

import UIKit

protocol IProfileViewPresenter {
    func logoutUser()
}

final class ProfileViewPresenter {
    weak var view: IProfileViewController?
    private let router: IBaseRouter
    private let authService: AuthService
    
    init(view: IProfileViewController, router: IBaseRouter, authService: AuthService) {
        self.view = view
        self.router = router
        self.authService = authService
    }
}

extension ProfileViewPresenter: IProfileViewPresenter {
    func logoutUser() {
        print("button logout tapped")
        
        authService.signOut { [weak self] error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let error = error {
                    if let viewController = self.view as? UIViewController {
                        AlertManager.showSignInAlert(on: viewController, with: error)
                    }
                    return
                }
                self.router.routeTo(target: BaseRouter.Target.loginVC)
            }
        }
    }
}
