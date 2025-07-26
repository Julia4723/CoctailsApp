//
//  DetailsViewPresenter.swift
//  CoctailsApp
//
//  Created by user on 16.07.2025.
//

import UIKit

struct DetailsModel {
    let image: String?
    let title: String?
    let instruction: String?
}

protocol IDetailsViewPresenter {
    func render()
    func renderIngredients()
}

final class DetailsViewPresenter {
    
    private weak var view: IDetailsViewController!
    private let authService: AuthService
    private let router: IBaseRouter
    private let model: Cocktail?
    private let modelCore: CocktailItem?
    
    init(view: IDetailsViewController, authService: AuthService, router: IBaseRouter, model: Cocktail?, modelCore: CocktailItem?) {
        self.view = view
        self.authService = authService
        self.router = router
        self.model = model
        self.modelCore = modelCore
    }
    
    private func getDetails() -> DetailsModel {
        if let model = model {
            return DetailsModel(image: model.strDrinkThumb, title: model.strDrink, instruction: model.strInstructions)
        } else if let modelCore = modelCore {
            //надо преобразовать data в строку
            return DetailsModel(image: nil, title: modelCore.title, instruction: modelCore.instruction)
        } else {
            return DetailsModel(image: nil, title: nil, instruction: nil)
        }
    }
    
    private func getIngredients() -> [String] {
        let arrayIngredients: [String] = model?.ingredients ?? []
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
