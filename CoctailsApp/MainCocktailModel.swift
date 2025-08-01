//
//  MainCocktailModel.swift
//  CoctailsApp
//
//  Created by user on 29.07.2025.
//

import Foundation
import UIKit

enum MainCocktailModel {
    case online(Cocktail)
    case save(CocktailsCore)
    
    var title: String {
        switch self {
        case .online(let cocktail):
            return cocktail.strDrink ?? "Без названия"
        case .save(let saved):
            return saved.title ?? "Без названия"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .online(let cocktail):
            if let urlString = cocktail.strDrinkThumb, let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
            }
            return nil
        case .save(let saved):
            if let data = saved.imageData {
                return UIImage(data: data)
            }
            return nil
        }
    }
    
    var imageURLString: String? {
        switch self {
        case .online(let cocktail):
            return cocktail.strDrinkThumb
        case .save(let saved):
            if let data = saved.imageData {
                return data.base64EncodedString()
            }
            return nil
        }
    }
    
    var instructions: String {
        switch self {
        case .online(let cocktail):
            return cocktail.strInstructions ?? "Без инструкции"
        case .save(let saved):
            return saved.instruction ?? "Без инструкции"
        }
    }
    
    var isSaved: Bool {
        switch self {
        case .online:
            return false
        case .save:
            return true
        }
    }
    
    var cocktailModel: Cocktail? {
        if case let .online(cocktail) = self {
            return cocktail
        }
        return nil
    }
    
    var cocktailIngredients: [String]? {
        if case let .online(cocktail) = self {
            return cocktail.ingredients
        }
        return nil
    }
    
    var cocktailItem: CocktailsCore? {
        if case let .save(item) = self {
            return item
        }
        return nil
    }
}

