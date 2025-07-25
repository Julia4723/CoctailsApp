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
    private var addImage = UIImageView()
    
    private let saveButton = CustomButton(title: "Save", hasBackground: true, fontSize: FontSize.middle)
    private let closeButton = CustomButton(title: "Close", fontSize: FontSize.middle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

extension NewCocktailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func addImageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            addImage.image = image
            //нужно обновить UI
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


extension NewCocktailViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        addSubViews()
        setupLayout()
        setupAddImageView()
        tapGesture()
        addAction()
    }
    
    func addAction() {
        saveButton.addTarget(self, action: #selector(buttonSaveTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(buttonCloseTapped), for: .touchUpInside)
    }
    
    func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addImageTapped))
        addImage.isUserInteractionEnabled = true
        addImage.addGestureRecognizer(tap)
    }
    
    @objc private func buttonSaveTapped() {
        print("Save button pressed")
        presenter?.save(
            title: textFieldName.text ?? "",
            instruction: textFieldInstruction.text ?? "",
            imageView: addImage.image
            
        )
        presenter?.didTapCloseButton()
    }
    
    @objc private func buttonCloseTapped() {
        presenter?.didTapCloseButton()
    }
    
    func setupAddImageView() {
        addImage.clipsToBounds = true
        addImage.layer.cornerRadius = 20
    }
    
    func addSubViews() {
        view.addViews(textFieldName, textFieldInstruction, saveButton, closeButton, addImage)
    }
    
    func setupLayout() {
        [textFieldName, textFieldInstruction, saveButton, closeButton, addImage] .forEach { view in
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
            
            addImage.topAnchor.constraint(equalTo: textFieldInstruction.bottomAnchor, constant: 12),
            addImage.leadingAnchor.constraint(equalTo: textFieldInstruction.leadingAnchor),
            addImage.trailingAnchor.constraint(equalTo: textFieldInstruction.trailingAnchor),
            addImage.heightAnchor.constraint(equalToConstant: 300),
            
            
            saveButton.topAnchor.constraint(equalTo: addImage.bottomAnchor, constant: 24),
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
