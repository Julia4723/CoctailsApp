//
//  UIStateManager.swift
//  CoctailsApp
//
//  Created by user on 31.07.2025.
//

import UIKit

private struct AssociatedKeys {
    static var stateManager = "uiStateManager"
}

// Протокол для доступа к UI
protocol UIStateManagerViewProtocol: AnyObject {
    var containerView: UIView { get }
    var navigationController: UINavigationController? { get }
}

// Основной протокол для UIStateManager
protocol UIStateManagerProtocol {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func showSuccess(_ message: String?)
}

// Extension для автоматического создания UIStateManager
extension UIStateManagerProtocol where Self: UIStateManagerViewProtocol {
    var uiStateManager: UIStateManagerProtocol {
        if let manager = objc_getAssociatedObject(self, AssociatedKeys.stateManager) as? UIStateManagerProtocol {
            return manager
        }
        let manager = UIStateManager(viewController: self)
        objc_setAssociatedObject(self, AssociatedKeys.stateManager, manager, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return manager
    }
}



final class UIStateManager {
    private weak var viewController: UIStateManagerViewProtocol?
    private var loadingView: UIView?
    private var successView: UIView?
    
    init(viewController: UIStateManagerViewProtocol) {
        self.viewController = viewController
    }
}



extension UIStateManager: UIStateManagerProtocol {
    
    func showLoading() {
        guard let view = viewController?.containerView else {return}
        
        // Создаём overlay для блокировки UI
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        overlay.tag = 999
        
        // Создаём индикатор загрузки
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        
        overlay.addSubview(activityIndicator)
        view.addSubview(overlay)
        
        overlay.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            overlay.topAnchor.constraint(equalTo: view.topAnchor),
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor)
        ])
        
        loadingView = overlay
        
        // Блокируем взаимодействие
        view.isUserInteractionEnabled = false
    }
    
    func hideLoading() {
        loadingView?.removeFromSuperview()
        loadingView = nil
        
        viewController?.containerView.isUserInteractionEnabled = true
    }
    
    func showError(_ message: String) {
        showToast(message: message, isError: true)
    }
    
    func showSuccess(_ message: String?) {
        showToast(message: message ?? "Operation completed successfully!", isError: false)
    }
    
    private func showToast(message: String, isError: Bool) {
        let toastView = UIView()
        toastView.backgroundColor = isError ? .systemRed : .systemGreen
        toastView.layer.cornerRadius = 8
        toastView.alpha = 0
        
        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        toastView.addSubview(label)
        viewController?.containerView.addSubview(toastView)
        
        toastView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toastView.centerXAnchor.constraint(equalTo: viewController?.containerView.centerXAnchor ?? toastView.centerXAnchor),
            toastView.bottomAnchor.constraint(equalTo: viewController?.containerView.safeAreaLayoutGuide.bottomAnchor ?? toastView.bottomAnchor, constant: -20),
            toastView.widthAnchor.constraint(lessThanOrEqualTo: viewController?.containerView.widthAnchor ?? toastView.widthAnchor, multiplier: 0.8),

            label.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -12)
        ])
        
        UIView.animate(withDuration: 0.3) {
            toastView.alpha = 1
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                UIView.animate(withDuration: 0.3) {
                    toastView.alpha = 0
                } completion: { _ in
                    toastView.removeFromSuperview()
                }
            }
        }
    }
}
