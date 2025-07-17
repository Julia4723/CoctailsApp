//
//  DetailsViewController.swift
//  CoctailsApp
//
//  Created by user on 16.07.2025.
//

import UIKit

protocol IDetailsViewController: AnyObject {
    func configure(item: DetailsModel)
}

final class DetailsViewController: UIViewController {
    var presenter: IDetailsViewPresenter!
    
    private let imageView = ContainerImageView()
    private let titleText = UILabel.makeLabel(text: "Title", font: UIFont.systemFont(ofSize: 32, weight: .bold), textColor: .black)
    private let descriptionText = UILabel.makeLabel(text: "Description", font: UIFont.systemFont(ofSize:17, weight: .regular), textColor: .black)
    private let ingredientsText = UILabel.makeLabel(text: "Ingr", font: UIFont.systemFont(ofSize:17, weight: .regular), textColor: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.render()
    }
    
}

private extension DetailsViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        addSubViews()
        setupLayout()
    }
    
    func addSubViews() {
        view.addViews(imageView, titleText, descriptionText, ingredientsText)
    }
}

private extension DetailsViewController {
    func setupLayout() {
        [
            imageView,
            titleText,
            descriptionText,
            ingredientsText
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 24),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            imageView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: titleText.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: titleText.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            
            descriptionText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            descriptionText.leadingAnchor.constraint(equalTo: titleText.leadingAnchor),
            descriptionText.trailingAnchor.constraint(equalTo: titleText.trailingAnchor),
            
            ingredientsText.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 12),
            ingredientsText.leadingAnchor.constraint(equalTo: descriptionText.leadingAnchor),
            ingredientsText.trailingAnchor.constraint(equalTo: descriptionText.trailingAnchor)
        ])
    }
}


extension DetailsViewController: IDetailsViewController {
    func configure(item: DetailsModel) {
        titleText.text = item.title
        descriptionText.text = item.description
        ingredientsText.text = item.ingredient.joined(separator: "\n")
        imageView.configure(urlImage: item.image ?? "")
    }
    
    
}
