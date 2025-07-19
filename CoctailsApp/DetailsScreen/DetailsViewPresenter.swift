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
    private let model: Cocktail
    
    init(view: IDetailsViewController, authService: AuthService, router: IBaseRouter, model: Cocktail) {
        self.view = view
        self.authService = authService
        self.router = router
        self.model = model
    }
    
    private func getDetails() -> DetailsModel {
        let detailItem = DetailsModel(image: model.strDrinkThumb, title: model.strDrink, instruction: model.strInstructions)
        return detailItem
    }
    
    private func getIngredients() -> [String] {
        let arrayIngredients: [String] = model.ingredients
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
