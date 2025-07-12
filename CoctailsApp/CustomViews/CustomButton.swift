//
//  CustomButton.swift
//  CoctailsApp
//
//  Created by user on 28.06.2025.
//

import UIKit

enum FontSize {
    case big
    case middle
    case small
}

final class CustomButton: UIButton {
    init(title: String, hasBackground: Bool = false, fontSize: FontSize, hasImage: Bool = false) {
        super.init(frame: .zero)
        setupButton(title, hasBackground, fontSize, hasImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CustomButton {
    private func setupButton(_ title: String, _ hasBackground: Bool, _ fontSize: FontSize, _ hasImage: Bool ) {
        setTitle(title, for: .normal)
        layer.cornerRadius = 12
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 10
        
        backgroundColor = hasBackground ? .systemBlue : .clear
        
        let titleColor: UIColor = hasBackground ? .white : .black
        setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        case .middle:
            titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        case .small:
            titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        }
    }
    
  
}
