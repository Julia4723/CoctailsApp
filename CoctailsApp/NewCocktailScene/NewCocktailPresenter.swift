//
//  NewCocktailPresenter.swift
//  CoctailsApp
//
//  Created by user on 19.07.2025.
//

import UIKit

protocol INewCocktailPresenter {
    func save(title: String, instruction: String, imageView: UIImage?)
    func closeAddNewCocktailScreen()
    func validateInput(title: String, instruction: String) -> Bool
}


final class NewCocktailPresenter {
    private weak var view: INewCocktailViewController!
    private let model: INewCocktailModel
    private let authService: AuthService
    private let router: IBaseRouter
  
    init(view: INewCocktailViewController, model: INewCocktailModel, authService: AuthService, router: IBaseRouter) {
        self.view = view
        self.model = model
        self.authService = authService
        self.router = router
       
    }
}


extension NewCocktailPresenter: INewCocktailPresenter {
    func validateInput(title: String, instruction: String) -> Bool {
        let validation = model.validateCocktail(title: title, instruction: instruction)
        if !validation.isValid {
            view.showError(validation.errors.joined(separator: "\n"))
        }
        return validation.isValid
    }
    
    func save(title: String, instruction: String, imageView: UIImage?) {
        view.showLoading()
        
        Task {
            do {
                try await model.saveCocktail(title: title, instruction: instruction, image: imageView)
                
                await MainActor.run {
                    view.hideLoading()
                    view.showSuccess("Done!")
                    
                    NotificationCenter.default.post(name: .didAddNewCocktail, object: nil)
                    closeAddNewCocktailScreen()
                }
            } catch {
                await MainActor.run {
                    view.hideLoading()
                    view.showError(error.localizedDescription)
                }
            }
        }
    }
    
    func closeAddNewCocktailScreen() {
        print("didTapCloseButton")
        router.routeTo(target: BaseRouter.Target.popToRoot)
    }
    
}
