//
//  MainPresenter.swift
//  CoctailsApp
//
//  Created by user on 03.07.2025.
//

import UIKit

struct MainModel {
    let title: String?
    let description: String?
    let image: String?
}

protocol IMainPresenter {
    func showScene(_ index: Int)
    func render()
    func fetchFromStorage()
    func fetchFromCore()
    func showNewCocktailVC()
    func deleteCoreItem(at index: IndexPath)
}


final class MainPresenter {
    
    weak var view: IMainViewController?
    private let network: INetworkManager
    private let router: IBaseRouter
    private var cocktails: [Cocktail] = []
    private var coreItems: [CocktailItem] = []
    
    
    init(view: IMainViewController, router: IBaseRouter, network: INetworkManager) {
        self.view = view
        self.router = router
        self.network = network
    }
}

extension MainPresenter: IMainPresenter {
    func deleteCoreItem(at index: IndexPath) {
        let item = coreItems[index.row]
        let coreManager = CoreDataManager.shared
        coreManager.delete(item)
        fetchFromCore()
    }
    
    
    
    func fetchFromCore() {
        let fetch = CocktailItem.fetchRequest()
        let coreManager = CoreDataManager.shared
        do {
            coreItems = try coreManager.persistentContainer.viewContext.fetch(fetch)
            DispatchQueue.main.async {
                       self.view?.configureCoreModel(items: self.coreItems)
                   }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchFromStorage() {
        self.network.fetchAF { [weak self] result in
            switch result {
            case .success(let success):
                self?.cocktails = success
                DispatchQueue.main.async {
                    self?.view?.configureCocktailModel(items: success)
                }
            case .failure(let failure):
                self?.view?.showError(error: failure)
            }
        }
    }
    
    func showScene(_ index: Int) {
        router.routeTo(target: BaseRouter.Target.detailsVC(item: cocktails[index]))
    }
    
    func render() {
        view?.configureCocktailModel(items: cocktails)
        view?.configureCoreModel(items: coreItems)
    }
    
    func showNewCocktailVC() {
        print("Presenter: showNewCocktailVC")
        router.routeTo(target: BaseRouter.Target.newCocktailVC)
    }
    
}
