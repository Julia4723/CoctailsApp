//
//  NewCocktailPresenter.swift
//  CoctailsApp
//
//  Created by user on 19.07.2025.
//

import UIKit

protocol INewCocktailPresenter {
    
}


final class NewCocktailPresenter {
    private weak var view: INewCocktailViewController!
    
    private let authService: AuthService
    private let router: IBaseRouter
  
    
    init(view: INewCocktailViewController, authService: AuthService, router: IBaseRouter) {
        self.view = view
        self.authService = authService
        self.router = router
    }
}


extension NewCocktailPresenter: INewCocktailPresenter {
    
}
