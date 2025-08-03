//
//  SceneDelegate.swift
//  CoctailsApp
//
//  Created by user on 27.06.2025.
//

import UIKit

import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
    
        window?.makeKeyAndVisible()
        checkAuthentication()
    }
    
    public func checkAuthentication() {
        let authService = AuthService()
        
        if Auth.auth().currentUser == nil { //если такого юзера нет
            let loginVC = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginVC)
            let loginAssembly = LoginAssembly(navigationController: navigationController, authService: authService)
            loginAssembly.configure(viewController: loginVC)
            self.window?.rootViewController = navigationController
            
        } else {
            self.goToController(with: TabBarController()) //если юзер есть
        }
    }
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            
            // Если это TabBarController, настраиваем его через Assembly
            if let tabBarController = viewController as? TabBarController {
                let authService = AuthService()
                
                let tabBarAssembly = TabBarAssembly(navigationController: nav, authService: authService)
                tabBarAssembly.configure(viewController: tabBarController)
            }
            
            self?.window?.rootViewController = nav
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    
}

