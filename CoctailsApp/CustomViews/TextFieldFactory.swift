//
//  TextFieldFactory.swift
//  CoctailsApp
//
//  Created by user on 19.07.2025.
//

import UIKit

final class TextFieldFactory {
    
    
    static func makeTextField(
        placeholder: String,
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        borderStyle: UITextField.BorderStyle = .roundedRect,
        backgroundColor: UIColor = .systemBackground,
        textColor: UIColor = .label,
        font: UIFont = UIFont.systemFont(ofSize: 16),
        leftPadding: CGFloat = 8
    ) -> UITextField {
        
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.borderStyle = borderStyle
        textField.backgroundColor = backgroundColor
        textField.textColor = textColor
        textField.font = font
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавление отступа слева
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }
}

