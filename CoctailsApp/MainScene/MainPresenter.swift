//
//  MainPresenter.swift
//  CoctailsApp
//
//  Created by user on 03.07.2025.
//

import UIKit


protocol IMainPresenter {
    func showScene(_ index: Int)
    func render()
    func fetchFromStorage()
    func fetchFromCore()
    func showNewCocktailVC()
    func deleteCoreItem(at index: IndexPath)
}


final class MainPresenter {
    
    private weak var view: IMainViewController?
    private let network: INetworkManager
    private let router: IBaseRouter
    private var cocktails: [Cocktail] = []
    private var coreItems: [CocktailsCore] = []
    
    
    init(view: IMainViewController, router: IBaseRouter, network: INetworkManager) {
        self.view = view
        self.router = router
        self.network = network
    }
    
    private func makeCombinedModel() -> [MainCocktailModel] {
        let onlineModels = cocktails.map { MainCocktailModel.online($0) }
        let savedModels = coreItems.map { MainCocktailModel.save($0) }
        return onlineModels + savedModels
    }
}

extension MainPresenter: IMainPresenter {
    func showScene(_ index: Int) {
        let combinedModel = makeCombinedModel()
        guard index < combinedModel.count else { return }
        let item = combinedModel[index]
        router.routeTo(target: BaseRouter.Target.detailsCoreModelVC(item: item))
    }
    
    func deleteCoreItem(at index: IndexPath) {
        // Получаем элемент по индексу из общего массива
        let combinedModel = makeCombinedModel()
        guard index.row < combinedModel.count else { return }
        let item = combinedModel[index.row]
        
        switch item {
        case .save(let coreItem):
            // Удаляем из CoreData
            CoreDataManager.shared.delete(coreItem)
            // Обновляем данные и UI
            fetchFromCore()
        case .online:
            // Онлайн элементы нельзя удалить
            print("Cannot delete online item")
        }
    }
    
    
    
    func fetchFromCore() {
        let fetchRequest = CocktailsCore.fetchRequest()
        do {
            coreItems = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            updateView()
        } catch {
            print("❌ CoreData fetch error: \(error.localizedDescription)")
        }
    }
    
    func fetchFromStorage() {
        network.fetchAF { [weak self] result in
            switch result {
            case .success(let cocktails):
                self?.cocktails = cocktails
                self?.updateView()
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func render() {
        updateView()
    }
    
    func showNewCocktailVC() {
        router.routeTo(target: BaseRouter.Target.newCocktailVC)
    }
    
    private func updateView() {
        DispatchQueue.main.async {
            let allModels = self.makeCombinedModel()
            self.view?.configure(items: allModels)
        }
    }
}
