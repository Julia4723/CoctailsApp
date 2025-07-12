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
    
    func configure(model: Cocktail) {
        titleLabel.text = model.strGlass
        descriptionLabel.text = model.strCategory
        imageView.configure(urlImage: model.strDrinkThumb ?? "") //кажется у модели нет картинок, првоерить
        
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
        titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        titleLabel.textColor = .black
    }
    
    func setupDescription() {
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = .black
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
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
}
