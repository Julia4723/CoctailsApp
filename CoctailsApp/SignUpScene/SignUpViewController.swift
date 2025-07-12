//
//  ViewController.swift
//  CoctailsApp
//
//  Created by user on 27.06.2025.
//

import UIKit

protocol ISignUpViewController: AnyObject {
    func showError(_ message: String)
    func showLoading(_ isLoading: Bool)
}

class SignUpViewController: UIViewController {
    
    var presenter: ISignUpViewPresenter! //ссылка на презентер
    
    private let nameField = CustomTextField(authFieldType: .userName)
    private let emailField = CustomTextField(authFieldType: .email)
    private let passwordField = CustomTextField(authFieldType: .password, isPrivate: true)
    private let confirmPasswordField = CustomTextField(authFieldType: .confirmPassword, isPrivate: true)
    
    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    private let signInButton = CustomButton(title: "Sign In", fontSize: .big)
    
    private let labelQuestion = UILabel.makeLabel(text: "Already have an account", font: .systemFont(ofSize: 14), textColor: .systemGray)
    
    
    private let stack = UIStackView()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SignUpViewController loaded")
        
        setupNavigationBar()
        setupView()
        setupLayout()
       
        nameField.delegate = self
        addActions()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func setupNavigationBar() {
        navigationItem.title = "Sign Up"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
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


extension SignUpViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        setupStack()
        addSubviews()
        stack.addArrangedSubview(labelQuestion)
        stack.addArrangedSubview(signInButton)
        
        // Настройка индикатора загрузки
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemBlue
    }
    
    func addActions() {
        signUpButton.addTarget(self, action: #selector(tapSignUpButton), for: .touchUpInside)
        
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
    }
    
    @objc func tapSignUpButton() {
        print("SignUp button")
        
        presenter.registerUser(
            userName: nameField.text ?? "",
            email: emailField.text ?? "",
            password: passwordField.text ?? "",
            confirmPassword: confirmPasswordField.text ?? ""
        )
    }
    
    @objc private func didTapSignInButton() {
        print("didTapSignInButton")
        presenter.runSignInFlow()
        
    }
    
    func addSubviews() {
        view.addViews(
            nameField,
            emailField,
            passwordField,
            confirmPasswordField,
            signUpButton,
            stack,
            activityIndicator
        )
    }
    
    func setupStack() {
        stack.axis = .horizontal
        stack.spacing = 4
    }
}


extension SignUpViewController {
    func setupLayout() {
        [
            nameField,
            emailField,
            passwordField,
            confirmPasswordField,
            signUpButton,
            stack,
            activityIndicator
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameField.heightAnchor.constraint(equalToConstant: 56),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 56),
            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 56),
            passwordField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            confirmPasswordField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 56),
            confirmPasswordField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 40),
            
            signUpButton.heightAnchor.constraint(equalToConstant: 58),
            signUpButton.leadingAnchor.constraint(equalTo: confirmPasswordField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: confirmPasswordField.trailingAnchor),
            
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.heightAnchor.constraint(equalToConstant: 24),
            
            // Констрейнты для индикатора загрузки
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension SignUpViewController: ISignUpViewController {
    func showError(_ message: String) {
        // Создаем кастомную ошибку для передачи в AlertManager
        let error = NSError(domain: "SignUpError", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
        AlertManager.showRegistrationErrorAlert(on: self, with: error)
    }
    
    func showLoading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            signUpButton.isEnabled = false
            signInButton.isEnabled = false
        } else {
            activityIndicator.stopAnimating()
            signUpButton.isEnabled = true
            signInButton.isEnabled = true
        }
    }
}


extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        //FIXME: проверить реализацию
    }
}

//
//#Preview(traits: .portrait) {
//
//        //let booksType = BookTypeManager()
//    SignUpViewController()
//
//}
