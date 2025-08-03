//
//  FavoriteManager.swift
//  CoctailsApp
//
//  Created by user on 02.08.2025.
//

import UIKit

protocol IFavoriteManager {
    func fetchAllModel() -> [MainCocktailModel]
    func getFavoriteCocktails() -> [MainCocktailModel]
    func addToFavorites(_ cocktail: MainCocktailModel)
    func removeFromFavorites(_ cocktail: MainCocktailModel)
    func isFavorite(_ cocktail: MainCocktailModel) -> Bool
    func updateAllModels(_ models: [MainCocktailModel])
}

final class FavoriteManager: IFavoriteManager {
    
    private var allModelsList: [MainCocktailModel] = []
    private var favoriteIds: Set<String> = []
    
    init() {
        loadFavorites()
    }
    
    func fetchAllModel() -> [MainCocktailModel] {
        allModelsList
    }
    
    func getFavoriteCocktails() -> [MainCocktailModel] {
        return fetchAllModel().filter { isFavorite($0) }
    }
    
    func addToFavorites(_ cocktail: MainCocktailModel) {
        let id = getCocktailId(cocktail)
        favoriteIds.insert(id)
        saveFavorites()
    }
    
    func removeFromFavorites(_ cocktail: MainCocktailModel) {
        let id = getCocktailId(cocktail)
        favoriteIds.remove(id)
        saveFavorites()
    }
    
    func isFavorite(_ cocktail: MainCocktailModel) -> Bool {
        let id = getCocktailId(cocktail)
        let result = favoriteIds.contains(id)
        return result
    }
    
    func updateAllModels(_ models: [MainCocktailModel]) {
        print("📋 FavoriteManager: Updating all models, current favorites: \(favoriteIds)")
        allModelsList = models
        print("📋 FavoriteManager: Now have \(models.count) models, favorites still: \(favoriteIds)")
    }
    
    private func getCocktailId(_ cocktail: MainCocktailModel) -> String {
        let id: String
        switch cocktail {
        case .online(let cocktail):
            id = cocktail.idDrink ?? cocktail.strDrink ?? ""
        case .save(let saved):
            id = saved.title ?? ""
        }
        print("🆔 FavoriteManager: Generated ID '\(id)' for '\(cocktail.title)'")
        return id
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(Array(favoriteIds), forKey: "FavoriteCocktails")
    }
    
    private func loadFavorites() {
        if let savedIds = UserDefaults.standard.array(forKey: "FavoriteCocktails") as? [String] {
            favoriteIds = Set(savedIds)
            print("📱 FavoriteManager: Loaded \(savedIds.count) favorites from UserDefaults: \(savedIds)")
        } else {
            print("📱 FavoriteManager: No saved favorites found in UserDefaults")
        }
    }
}
