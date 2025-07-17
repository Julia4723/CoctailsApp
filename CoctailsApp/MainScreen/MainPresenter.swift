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
}


final class MainPresenter: IMainPresenter {
    weak var view: IMainViewController?
    private let network: INetworkManager
    private let router: IBaseRouter
    private var cocktails: [Cocktail] = []
    
    
    init(view: IMainViewController, router: IBaseRouter, network: INetworkManager) {
        self.view = view
        self.router = router
        self.network = network
    }
    
    func fetchFromStorage() {
        self.network.fetchAF { [weak self] result in
            switch result {
            case .success(let success):
                self?.cocktails = success
                DispatchQueue.main.async {
                    self?.view?.configure(items: success)
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
        view?.configure(items: cocktails)
    }
}

extension MainPresenter {
    
    
    
}
