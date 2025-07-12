//
//  FirstViewPresenter.swift
//  CoctailsApp
//
//  Created by user on 27.06.2025.
//

import UIKit

//Добавить обработку вью модели



protocol ISignUpViewPresenter {
    func runSignInFlow()
    func registerUser(userName: String, email: String, password: String, confirmPassword: String)
}


final class SignUpViewPresenter {
    private weak var view: ISignUpViewController?
    private var name = "Nik"
    
    private let router: IBaseRouter
    private let authService: AuthService
    
    init(router: IBaseRouter, view: ISignUpViewController, authService: AuthService) {
        self.router = router
        self.view = view
        self.authService = authService
    }
}


extension SignUpViewPresenter: ISignUpViewPresenter {
    func registerUser(userName: String, email: String, password: String, confirmPassword: String) {
        // Валидация
        guard !userName.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            view?.showError("Все поля должны быть заполнены")
            return
        }
        
        guard password == confirmPassword else {
            view?.showError("Пароли не совпадают")
            return
        }
        
        guard password.count >= 6 else {
            view?.showError("Пароль должен содержать минимум 6 символов")
            return
        }
        
        // Показать индикатор загрузки
        view?.showLoading(true)
        
        authService.registerUser(with: RegisterUserRequest(userName: userName, email: email, password: password, confirmPassword: confirmPassword)) { [weak self] wasRegistered, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                // Скрыть индикатор загрузки
                self.view?.showLoading(false)
                
                if let error = error {
                    self.view?.showError(error.localizedDescription)
                    return
                }
                
                if wasRegistered {
                    // Успешная регистрация - переход на TabBarController
                    self.router.routeTo(target: BaseRouter.Target.main)
                } else {
                    self.view?.showError("Ошибка регистрации")
                }
            }
        }
    }
    
    func runSignInFlow() { //метод для открытия экрана логина
        print("button Sign In tapped")
        
        router.routeTo(target: BaseRouter.Target.popToRoot)
    }
}
