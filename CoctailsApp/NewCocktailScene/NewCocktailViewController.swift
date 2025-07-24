//
//  NewCocktailViewController.swift
//  CoctailsApp
//
//  Created by user on 19.07.2025.
//

import UIKit

protocol INewCocktailViewController: AnyObject {
    
    
    
}


final class NewCocktailViewController: UIViewController {
    
    var presenter: INewCocktailPresenter?
    
    private let textFieldName = TextFieldFactory.makeTextField(placeholder: "Name")
    private let textFieldInstruction = TextFieldFactory.makeTextField(placeholder: "Instruction")
    private let saveButton = CustomButton(title: "Save", hasBackground: true, fontSize: FontSize.middle)
    private let closeButton = CustomButton(title: "Close", fontSize: FontSize.middle)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}


private extension NewCocktailViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        addSubViews()
        setupLayout()
        addAction()
    }
    
    func addAction() {
        saveButton.addTarget(self, action: #selector(buttonSaveTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(buttonCloseTapped), for: .touchUpInside)
    }
    
    @objc private func buttonSaveTapped() {
        print("Save button pressed")
        presenter?.save(
            title: textFieldName.text ?? "",
            instruction: textFieldInstruction.text ?? ""
        )
        presenter?.didTapCloseButton()
    }
    
    @objc private func buttonCloseTapped() {
        presenter?.didTapCloseButton()
    }
    
    func addSubViews() {
        view.addViews(textFieldName, textFieldInstruction, saveButton, closeButton)
    }
    
    func setupLayout() {
        [textFieldName, textFieldInstruction, saveButton, closeButton] .forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            textFieldName.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12),
            textFieldName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textFieldName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            textFieldName.heightAnchor.constraint(equalToConstant: 52),
            
            textFieldInstruction.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 12),
            textFieldInstruction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textFieldInstruction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            textFieldInstruction.heightAnchor.constraint(equalToConstant: 52),
            
            
            saveButton.topAnchor.constraint(equalTo: textFieldInstruction.bottomAnchor, constant: 24),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 52),
            
            closeButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 12),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            closeButton.heightAnchor.constraint(equalToConstant: 52),
        ])
        
    }
}

extension NewCocktailViewController: INewCocktailViewController {
    
}
