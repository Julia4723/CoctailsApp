//
//  LoginViewController.swift
//  CoctailsApp
//
//  Created by user on 28.06.2025.
//

import UIKit

protocol ILoginViewController: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func showSuccess(_ message: String?)
}

final class LoginViewController: UIViewController {
    
    var presenter: ILoginPresenter?
    
    private let emailField = CustomTextField(authFieldType: .email)
    private let passwordField = CustomTextField(authFieldType: .password, isPrivate: true)
    private let confirmPasswordField = CustomTextField(authFieldType: .confirmPassword, isPrivate: true)
    private let loginButton = CustomButton(title: "Login",hasBackground: true, fontSize: .big)
    private let registrationButton = CustomButton(title: "Sign Up", fontSize: .big)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        presenter?.render()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Sign In"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backItem?.leftBarButtonItem = .none
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}


private extension LoginViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        addSubViews()
        setupLayout()
        addAction()
    }
}


private extension LoginViewController {
    func addSubViews() {
        view.addViews(
            emailField,
            passwordField,
            confirmPasswordField,
            loginButton,
            registrationButton
        )
    }
    
    
    @objc private func loginButtonTapped() {
        print("Login Button tapped")
        let loginRequest = LoginUserRequest(
            email: emailField.text ?? "",
            password: passwordField.text ?? ""
        )
        presenter?.login(email: loginRequest.email, password: loginRequest.password)
    }
    
    @objc private func registrationButtonTapped() {
        print("Registration Button tapped")
        presenter?.didTapSignUpButton()
    }
    
    func addAction() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
    }
    
}


private extension LoginViewController {
    private func setupLayout() {
        [
            emailField,
            passwordField,
            confirmPasswordField,
            loginButton,
            registrationButton
            
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            emailField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailField.heightAnchor.constraint(equalToConstant: 52),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 32),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            passwordField.heightAnchor.constraint(equalToConstant: 52),
            
            confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 32),
            confirmPasswordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            confirmPasswordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 52),
            
            loginButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            
            
            registrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            registrationButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}


extension LoginViewController: ILoginViewController, UIStateManagerViewProtocol, UIStateManagerProtocol {
    
    var containerView: UIView {
        return view
    }
    
    func showSuccess(_ message: String?) {
        uiStateManager.showSuccess(message)
    }
    
    func showLoading() {
        uiStateManager.showLoading()
    }
    
    func hideLoading() {
        uiStateManager.hideLoading()
    }
    
    func showError(_ message: String) {
        uiStateManager.showError(message)
    }
}
