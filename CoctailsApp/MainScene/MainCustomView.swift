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
    private var imageView = ContainerImageView()
    private var imageFromCoreData = UIImage()
    private let like = UIImageView(image: UIImage(systemName: "heart"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForReuse() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        imageView.prepareForReuse()
    }
    
    func configureCocktailModel(model: Cocktail) {
        titleLabel.text = model.strDrink
        descriptionLabel.text = model.strCategory
        imageView.configure(urlImage: model.strDrinkThumb ?? "")
        
        
    }
    
    func configureCoreModel(model: CocktailsCore) {
        descriptionLabel.text = model.instruction
        titleLabel.text = model.title
        if let data = model.imageData {
            imageView.configureData(data: data)
        }
    }
}


private extension MainCustomView {
    func setup() {
        setupView()
        addSubviews()
        setupTitleLabel()
        setupDescription()
        setupImage()
        setupLayout()
    }
    
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
    }
    
    func addSubviews() {
        [titleLabel, descriptionLabel, imageView, like].forEach { view in
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
        descriptionLabel.numberOfLines = 1
        descriptionLabel.lineBreakMode = .byTruncatingTail
    }
    
    func setupImage() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
    }
    
}

private extension MainCustomView {
    func setupLayout() {
        [titleLabel, descriptionLabel, imageView, like].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalToConstant: 280),
            
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            like.heightAnchor.constraint(equalToConstant: 24),
            like.widthAnchor.constraint(equalToConstant: 24),
            like.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            like.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4)
        ])
    }
}
