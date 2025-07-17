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
    let description: String?
    let ingredient: [String]
}

protocol IDetailsViewPresenter {
    func render()
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
        let detailItem = DetailsModel(image: model.strDrinkThumb, title: model.strDrink, description: model.strCategory, ingredient: model.ingredients)
        return detailItem
    }
}


extension DetailsViewPresenter: IDetailsViewPresenter {
    func render() {
        view.configure(item: getDetails())
    }
}
