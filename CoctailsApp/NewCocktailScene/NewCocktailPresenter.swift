//
//  NewCocktailPresenter.swift
//  CoctailsApp
//
//  Created by user on 19.07.2025.
//

import UIKit

protocol INewCocktailPresenter {
    func save(title: String, instruction: String, imageView: UIImage?)
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
    func save(title: String, instruction: String, imageView: UIImage?) {
        print("Saving cocktail: \(title), \(instruction)")
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let item = CocktailItem(context: context)
        item.title = title
        item.instruction = instruction
        
        if let image = imageView, let data = image.jpegData(compressionQuality: 0.8) {
            item.imageData = data
        }
        
        CoreDataManager.shared.saveContext()
        NotificationCenter.default.post(name: .didAddNewCocktail, object: nil)
        
    }
    
    func didTapCloseButton() {
        print("didTapCloseButton")
        router.routeTo(target: BaseRouter.Target.popToRoot)
    }
    
}
