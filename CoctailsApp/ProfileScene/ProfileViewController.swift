//
//  ProfileViewController.swift
//  CoctailsApp
//
//  Created by user on 07.07.2025.
//

import UIKit

protocol IProfileViewController: AnyObject {
    
}

final class ProfileViewController: UIViewController {
    var presenter: IProfileViewPresenter!
    
    private let buttonLogOut = CustomButton(title: "Logout", fontSize: FontSize.big)
    
    override func viewDidLoad() {
        print("profile view loaded")
        assert(presenter != nil, "Presenter must not be nil!")
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Profile"
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

private extension ProfileViewController {
    func setupView() {
        view.backgroundColor = .systemBlue
        addSubViews()
        setupLayout()
        addAction()
        
    }
}

private extension ProfileViewController {
    func addSubViews() {
        view.addViews(buttonLogOut)
    }
    
    func addAction() {
        buttonLogOut.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logoutButtonTapped() {
        print("Logout button tapped")
        presenter.logoutUser()
    }
}

private extension ProfileViewController {
    func setupLayout() {
        [buttonLogOut].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            buttonLogOut.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32),
            buttonLogOut.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            buttonLogOut.widthAnchor.constraint(equalToConstant: 120),
            buttonLogOut.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
}


extension ProfileViewController: IProfileViewController {
    
}
