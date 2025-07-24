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
    func fetchFromCore() {
        let fetch = CocktailItem.fetchRequest()
        let context = CoreDataManager.shared
        do {
            coreItems = try context.persistentContainer.viewContext.fetch(fetch)
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
                    self?.view?.configureCoctailModel(items: success)
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
        view?.configureCoctailModel(items: cocktails)
        view?.configureCoreModel(items: coreItems)
    }
    
    func showNewCocktailVC() {
        print("Presenter: showNewCocktailVC")
        router.routeTo(target: BaseRouter.Target.newCocktailVC)
    }
    
}
