//
//  NewCocktailPresenter.swift
//  CoctailsApp
//
//  Created by user on 19.07.2025.
//

import UIKit

protocol INewCocktailPresenter {
    func save(title: String, instruction: String)
    func didTapCloseButton()
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
    func save(title: String, instruction: String) {
        print("Saving cocktail: \(title), \(instruction)")
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let entity = CocktailItem(context: context)
        entity.title = title
        entity.instruction = instruction
        
        CoreDataManager.shared.saveContext()
        NotificationCenter.default.post(name: .didAddNewCocktail, object: nil)
        
    }
    
    func didTapCloseButton() {
        print("didTapCloseButton")
        router.routeTo(target: BaseRouter.Target.popToRoot)
    }
    
}
