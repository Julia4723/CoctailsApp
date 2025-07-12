//
//  MVXProtocol.swift
//  CoctailsApp
//
//  Created by user on 27.06.2025.
//

import UIKit

protocol BaseAssembly {
    func configure(viewController: UIViewController)
}


protocol BaseRouting {
    func routeTo(target: Any)
    init(navigationController: UINavigationController, authService: AuthService)
}
