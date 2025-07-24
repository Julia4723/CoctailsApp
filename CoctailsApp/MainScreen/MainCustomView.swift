//
//  MainCustomView.swift
//  CoctailsApp
//
//  Created by user on 11.07.2025.
//

import UIKit

final class MainCustomView: UIView {
    
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageView = ContainerImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCocktailModel(model: Cocktail) {
//        titleLabel.text = model.title
//        descriptionLabel.text = model.description
//        imageView.configure(urlImage: model.image ?? "")
        titleLabel.text = model.strDrink
        descriptionLabel.text = model.strCategory
        imageView.configure(urlImage: model.strDrinkThumb ?? "")
        
    }
    
    func configureCoreModel(model: CocktailItem) {
        titleLabel.text = model.title
        descriptionLabel.text = model.instruction
    }
}


private extension MainCustomView {
    func setup() {
        addSubviews()
        setupTitleLabel()
        setupDescription()
        setupImage()
        setupLayout()
    }
    
    func addSubviews() {
        [titleLabel, descriptionLabel, imageView].forEach { view in
            addSubview(view)
        }
    }
}


private extension MainCustomView {
    func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .black
    }
    
    func setupDescription() {
        descriptionLabel.font = .systemFont(ofSize: 17, weight: .regular)
        descriptionLabel.textColor = .systemGray
    }
    
    func setupImage() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
    }
}

private extension MainCustomView {
    func setupLayout() {
        [titleLabel, descriptionLabel, imageView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ])
    }
}
