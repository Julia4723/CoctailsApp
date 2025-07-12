//
//  MainPresenter.swift
//  CoctailsApp
//
//  Created by user on 03.07.2025.
//

import UIKit

protocol IMainPresenter {
    var view: IMainViewController? {get set}
    var cocktails: [Cocktail] { get }
    func fetchFromStorage()
}


final class MainPresenter: IMainPresenter {
    
    
    weak var view: IMainViewController?
    private let network: INetworkManager
    private let router: IBaseRouter
    
    private(set) var cocktails: [Cocktail] = []
    
    
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
                    self?.view?.updateView()
                }
            case .failure(let failure):
                self?.view?.showError(error: failure)
            }
        }
    }
    
}

extension MainPresenter {
    
    
    
}
