//
//  CustomViewCell.swift
//  CoctailsApp
//
//  Created by user on 10.07.2025.
//

import UIKit

final class MainViewCell: UITableViewCell {
    
    private let customView = MainCustomView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Cocktail) {
        customView.configure(model: model)
    }
    

}


private extension MainViewCell {
    func setup() {
        contentView.addSubview(customView)
        contentView.backgroundColor = .systemBackground
        setupLayout()
    }
}


private extension MainViewCell {
    func setupLayout() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
