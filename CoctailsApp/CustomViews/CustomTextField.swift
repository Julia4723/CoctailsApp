//
//  CustomTextField.swift
//  CoctailsApp
//
//  Created by user on 28.06.2025.
//

import UIKit

enum CustomTextFieldType {
    case userName
    case email
    case password
    case confirmPassword
}

final class CustomTextField: UITextField, UITextFieldDelegate {
    
    private let authFieldType: CustomTextFieldType
    
    private var eyeButton: UIButton?
    
    init(authFieldType: CustomTextFieldType, isPrivate: Bool = false) {
        self.authFieldType = authFieldType
        super.init(frame: .zero)
        
        delegate = self
        
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray.cgColor
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        if isPrivate {
            isSecureTextEntry = true
            setupEyeButton()
        }
        
        switch authFieldType {
        case .userName:
            self.placeholder = "Fill name"
        case .email:
            self.placeholder = "Your email"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        case .password:
            self.placeholder = "Your password"
        case .confirmPassword:
            self.placeholder = "Confirm password"
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupEyeButton() {
        let buttonSize: CGFloat = 24
        
        eyeButton = UIButton(type: .custom)
        eyeButton?.setImage(UIImage(named: "eyeClose"), for: .normal)
        eyeButton?.setImage(UIImage(named: "eyeOpen"), for: .selected)
        eyeButton?.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        let buttonContainer = UIView(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
        eyeButton?.frame = buttonContainer.bounds
        buttonContainer.addSubview(eyeButton!)
        
        rightView = buttonContainer
        rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        eyeButton?.isSelected.toggle()
    }
   
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 10
        return rect
    }
    
}



