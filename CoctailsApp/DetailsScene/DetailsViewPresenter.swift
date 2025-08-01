//
//  DetailsViewPresenter.swift
//  CoctailsApp
//
//  Created by user on 16.07.2025.
//

import UIKit

struct DetailsModel {
    let image: String?
   // let imageCore: Data?
    let title: String?
    let instruction: String?
    let ingredients: [String]?
}

protocol IDetailsViewPresenter {
    func render()
    func renderIngredients()
}

final class DetailsViewPresenter {
    
    private weak var view: IDetailsViewController!
    private let authService: AuthService
    private let router: IBaseRouter
    private let allModels: MainCocktailModel
    //private let model: Cocktail
    //private let modelCore: CocktailItem?
    
    init(view: IDetailsViewController, authService: AuthService, router: IBaseRouter, allModels: MainCocktailModel) {
        self.view = view
        self.authService = authService
        self.router = router
        self.allModels = allModels
    }
    
    private func getDetails() -> DetailsModel {
       
        return DetailsModel(image: allModels.imageURLString, title: allModels.title, instruction: allModels.instructions, ingredients: allModels.cocktailIngredients)
        
    }
    
    private func getIngredients() -> [String] {
        let arrayIngredients: [String] = allModels.cocktailIngredients ?? []
        return arrayIngredients
    }
}


extension DetailsViewPresenter: IDetailsViewPresenter {
    func renderIngredients() {
        view.configureIngredients(array: getIngredients())
    }
    
    func render() {
        view.configure(item: getDetails())
    }
}
