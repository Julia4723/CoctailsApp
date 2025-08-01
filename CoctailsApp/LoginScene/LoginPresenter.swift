//
//  LoginPresenter.swift
//  CoctailsApp
//
//  Created by user on 28.06.2025.
//

import UIKit


protocol ILoginPresenter {
    func render()
    func login(email: String, password: String)
    func didTapSignUpButton()
}

final class LoginPresenter {
    
    private weak var view: ILoginViewController!
    private let authService: AuthService
    private let router: IBaseRouter
  
    
    init(view: ILoginViewController, authService: AuthService, router: IBaseRouter) {
        self.view = view
        self.authService = authService
        self.router = router
    }
}


extension LoginPresenter: ILoginPresenter {
    func didTapSignUpButton() {
        print("Presenter: didTapSignUpButton")
        router.routeTo(target: BaseRouter.Target.signUpVC)
        
    }
    
    func login(email: String, password: String) {
        view.showLoading()
        authService.signIn(with: LoginUserRequest(email: email, password: password)) { [weak self] error in
            DispatchQueue.main.async {
                self?.view.hideLoading()
                if let error = error {
                    self?.view.showError(error.localizedDescription)
                    return
                }
                self?.view.showSuccess("Login successful!")
                self?.router.routeTo(target: BaseRouter.Target.main)
            }
        }
    }
    
    
    func render() {
    //FIXME: проверить реализацию
    }
    
}
